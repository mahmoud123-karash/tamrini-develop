import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/features/trainee/data/data_sources/remote_data_source/trainee_remote_data_source.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/domain/repo/trainee_repo.dart';

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
  Future<Either<String, List<TraineeModel>>> reNewSubUser(
      {required String trainerId, required TraineeModel model}) {
    // TODO: implement reNewSubUser
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<TraineeModel>>> subUser({
    required String trainerId,
    required int traineesCount,
    required num profits,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      TraineeModel model = TraineeModel(
        uid: uid,
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

      await updateTrainer(trainerId, traineesCount, profits);
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
      "traineesCount": traineesCount + 1,
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
}
