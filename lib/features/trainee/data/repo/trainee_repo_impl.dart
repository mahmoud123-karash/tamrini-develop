import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/trainee/data/data_sources/remote_data_source/trainee_remote_data_source.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/food_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/domain/repo/trainee_repo.dart';
import 'package:uuid/uuid.dart';

class TraineeRepoImpl extends TraineeRepo {
  final TraineeRemoteDataSource traineeRemoteDataSource;
  final DioHelper dioHelper;

  TraineeRepoImpl(this.traineeRemoteDataSource, this.dioHelper);
  @override
  Future<Either<String, List<TraineeModel>>> getTrainees(
      {required String trainerId}) async {
    try {
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: trainerId);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TraineeModel>>> reNewSubUser({
    required String trainerId,
    required int traineesCount,
    required num profits,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(trainerId)
          .collection('data')
          .doc(uid)
          .update(
        {
          "dateOfSubscription": Timestamp.now(),
        },
      );
      await updateTrainer(trainerId, traineesCount, profits);
      sendReNewNotification(userId: uid, trainerId: trainerId);
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: trainerId);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendReNewNotification({
    required String userId,
    required String trainerId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'trainee',
      senderUid: userId,
      title: 'renew_trainee',
      body: '',
      type: 'notification',
      uid: userId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(trainerId)
        .collection('data')
        .add(
          notification.toJson(),
        );
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(trainerId)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'قام المتدرب يتجديد الإشتراك',
        body: 'تهانينا لقد قام المتدرب يتجديد الإشتراك',
        data: {
          "type": "notification",
          "subType": "trainee",
          "uid": userId,
        },
      );
    }
  }

  @override
  Future<Either<String, List<TraineeModel>>> subUser({
    required String trainerId,
    required int traineesCount,
    required num profits,
  }) async {
    try {
      var uuid = const Uuid().v4();
      String uid = CacheHelper.getData(key: 'uid');
      TraineeModel model = TraineeModel(
        uid: uid,
        chatId: uuid,
        isRating: false,
        dateOfSubscription: Timestamp.now(),
        supplements: [],
        food: [],
        followUpList: [],
        courses: [],
      );
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(trainerId)
          .collection('data')
          .doc(uid)
          .set(
            model.toJson(),
          );

      await updateTrainer(trainerId, traineesCount + 1, profits);
      updateUser(uid, trainerId);
      sendNotification(userId: uid, trainerId: trainerId);
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: trainerId);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  void updateUser(String uid, String trainerId) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update(
      {
        "trainerId": trainerId,
      },
    );
    saveTrainerId(trainerId);
  }

  Future<void> updateTrainer(
    String trainerId,
    int traineesCount,
    num profits,
  ) async {
    await FirebaseFirestore.instance
        .collection('trainers')
        .doc('data')
        .collection('data')
        .doc(trainerId)
        .update({
      "traineesCount": traineesCount,
      "profits": profits,
    });
  }

  Future<void> sendNotification({
    required String userId,
    required String trainerId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'trainee',
      senderUid: userId,
      title: 'new_trainee',
      body: '',
      type: 'notification',
      uid: userId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(trainerId)
        .collection('data')
        .add(
          notification.toJson(),
        );
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(trainerId)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'انضم متدرب جديد الى فرقك',
        body: 'تهانينا لقد انضم مترب جديد الى فريقك',
        data: {
          "type": "notification",
          "subType": "trainee",
          "uid": userId,
        },
      );
    }
  }

  @override
  Future<Either<String, List<TraineeModel>>> addNewCourse({
    required TraineeModel model,
    required DayWeekExercises dayWeekExercises,
    required String duration,
    required String notes,
    required String title,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      CourseModel courseModel = CourseModel(
        dayWeekExercises: dayWeekExercises,
        duration: duration,
        notes: notes,
        title: title,
        createdAt: Timestamp.now(),
      );
      List<CourseModel> courses = model.courses;
      courses.add(courseModel);
      TraineeModel newModel = TraineeModel(
        uid: model.uid,
        dateOfSubscription: model.dateOfSubscription,
        supplements: model.supplements,
        chatId: model.chatId,
        isRating: model.isRating,
        food: model.food,
        followUpList: model.followUpList,
        courses: courses,
      );
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(uid)
          .collection('data')
          .doc(model.uid)
          .set(
            newModel.toJson(),
          );
      await sendUpdateCourseNotification(userId: model.uid, trainerId: uid);
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: uid);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TraineeModel>>> addSupplements({
    required TraineeModel model,
    required List<String> supplements,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');

      List<String> newList = model.supplements;
      newList.addAll(supplements);
      TraineeModel newModel = TraineeModel(
        uid: model.uid,
        dateOfSubscription: model.dateOfSubscription,
        supplements: newList,
        chatId: model.chatId,
        isRating: model.isRating,
        food: model.food,
        followUpList: model.followUpList,
        courses: model.courses,
      );
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(uid)
          .collection('data')
          .doc(model.uid)
          .set(
            newModel.toJson(),
          );

      await sendUpdateCourseNotification(userId: model.uid, trainerId: uid);
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: uid);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TraineeModel>>> removeSupplement({
    required TraineeModel model,
    required String supplementId,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');

      List<String> newList = model.supplements;
      newList.remove(supplementId);
      TraineeModel newModel = TraineeModel(
        uid: model.uid,
        dateOfSubscription: model.dateOfSubscription,
        supplements: newList,
        food: model.food,
        isRating: model.isRating,
        chatId: model.chatId,
        followUpList: model.followUpList,
        courses: model.courses,
      );
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(uid)
          .collection('data')
          .doc(model.uid)
          .set(
            newModel.toJson(),
          );
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: uid);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TraineeModel>>> addDietCourse({
    required TraineeModel model,
    required String name,
    required String duration,
    required String satData,
    required String sunData,
    required String monData,
    required String wenData,
    required String tueData,
    required String thrusData,
    required String friData,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');

      List<FoodModel> newList = model.food;

      FoodModel foodModel = FoodModel(
        duration: duration,
        title: name,
        createdAt: Timestamp.now(),
        satData: satData,
        sunData: sunData,
        monData: monData,
        tueData: tueData,
        wedData: wenData,
        thursData: thrusData,
        friData: friData,
      );
      newList.add(foodModel);
      TraineeModel newModel = TraineeModel(
        uid: model.uid,
        dateOfSubscription: model.dateOfSubscription,
        supplements: model.supplements,
        food: newList,
        isRating: model.isRating,
        chatId: model.chatId,
        followUpList: model.followUpList,
        courses: model.courses,
      );
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(uid)
          .collection('data')
          .doc(model.uid)
          .set(
            newModel.toJson(),
          );
      await sendUpdateCourseNotification(userId: model.uid, trainerId: uid);
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: uid);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TraineeModel>>> removeDietCourse({
    required TraineeModel model,
    required FoodModel foodModel,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');

      List<FoodModel> newList = model.food;
      newList.remove(foodModel);
      TraineeModel newModel = TraineeModel(
        uid: model.uid,
        isRating: model.isRating,
        dateOfSubscription: model.dateOfSubscription,
        supplements: model.supplements,
        food: newList,
        followUpList: model.followUpList,
        chatId: model.chatId,
        courses: model.courses,
      );
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(uid)
          .collection('data')
          .doc(model.uid)
          .set(
            newModel.toJson(),
          );
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: uid);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, TraineeModel>> getUserCourse() async {
    try {
      TraineeModel model = await traineeRemoteDataSource.getUserCourse();
      bool isEnd = model.dateOfSubscription
          .toDate()
          .add(const Duration(days: 30))
          .isBefore(DateTime.now());
      log(model.dateOfSubscription.toDate().toString());
      log(isEnd.toString());
      saveisEnd(isEnd);
      return right(model);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, TraineeModel>> addNewFollow({
    required TraineeModel traineeModel,
    required List<String> paths,
    required List<FollowUpData> followUpData,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      String trainerId = CacheHelper.getData(key: 'trainerId');
      List files = [];
      for (var element in paths) {
        files.add(File(element));
      }
      List<String> images = await uploadFiles(files: files);
      FollowUpModel followUpModel = FollowUpModel(
        createdAt: Timestamp.now(),
        followUpData: followUpData,
        images: images,
      );

      List<FollowUpModel> list = traineeModel.followUpList;
      list.add(followUpModel);
      TraineeModel trainee = TraineeModel(
        uid: traineeModel.uid,
        isRating: traineeModel.isRating,
        dateOfSubscription: traineeModel.dateOfSubscription,
        supplements: traineeModel.supplements,
        food: traineeModel.food,
        chatId: traineeModel.chatId,
        followUpList: list,
        courses: traineeModel.courses,
      );
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(trainerId)
          .collection('data')
          .doc(uid)
          .update(
            trainee.toJson(),
          );
      await sendFollowNotification(userId: uid, trainerId: trainerId);
      TraineeModel model = await traineeRemoteDataSource.getUserCourse();
      return right(model);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendUpdateCourseNotification({
    required String userId,
    required String trainerId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'course',
      senderUid: trainerId,
      title: 'course',
      body: '',
      type: 'notification',
      uid: '',
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(userId)
        .collection('data')
        .doc(userId)
        .set(
          notification.toJson(),
        );
    var data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: "الكورس التدريبي",
        body: 'قام مدربك بتحديث الكورس التدريبي',
        data: {
          "type": "notification",
          "subType": "course",
        },
      );
    }
  }

  Future<void> sendFollowNotification({
    required String userId,
    required String trainerId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'follow',
      senderUid: userId,
      title: 'follow',
      body: '',
      type: 'notification',
      uid: userId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(trainerId)
        .collection('data')
        .doc(userId)
        .set(
          notification.toJson(),
        );
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(trainerId)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: "المتابعة",
        body: 'قام المتدرب بإضافة متابعة جديدة',
        data: {
          "type": "notification",
          "subType": "follow",
          "uid": userId,
        },
      );
    }
  }

  @override
  Future<Either<String, TraineeModel>> rateTrainer({
    required TraineeModel traineeModel,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      String trainerId = CacheHelper.getData(key: 'trainerId');
      TraineeModel trainee = TraineeModel(
        uid: traineeModel.uid,
        isRating: true,
        dateOfSubscription: traineeModel.dateOfSubscription,
        supplements: traineeModel.supplements,
        food: traineeModel.food,
        chatId: traineeModel.chatId,
        followUpList: traineeModel.followUpList,
        courses: traineeModel.courses,
      );
      await FirebaseFirestore.instance
          .collection('trainees')
          .doc(trainerId)
          .collection('data')
          .doc(uid)
          .update(
            trainee.toJson(),
          );
      TraineeModel model = await traineeRemoteDataSource.getUserCourse();
      return right(model);
    } catch (e) {
      return left(e.toString());
    }
  }
}
