import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/trainer/data/data_sources/remote_data_source/trainer_remote_data_source.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/gallery_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/domain/repo/trainer_repo.dart';

class TrainerRepoImpl extends TrainerRepo {
  final TrainerRemoteDataSource trainerRemoteDataSource;
  final DioHelper dioHelper;

  TrainerRepoImpl(this.trainerRemoteDataSource, this.dioHelper);
  @override
  Future<Either<String, List<TrainerModel>>> get() async {
    try {
      List<TrainerModel> list = await trainerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TrainerModel>>> banTrainer({
    required String trainerId,
    required bool isBanned,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .doc(trainerId)
          .update({
        "isBanned": isBanned,
      });

      await sendNotification(isBanned: isBanned, trainerId: trainerId);
      List<TrainerModel> list = await trainerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TrainerModel>>> editTrainer({
    required TrainerModel trainer,
    required String description,
    required int price,
    required String fromH,
    required String toH,
  }) async {
    try {
      TrainerModel model = TrainerModel(
        isBanned: trainer.isBanned,
        description: description,
        isRequestProfits: trainer.isRequestProfits,
        uid: trainer.uid,
        questionsTrainees: trainer.questionsTrainees,
        profits: trainer.profits,
        price: price,
        traineesCount: trainer.traineesCount,
        gallery: trainer.gallery,
        fromH: fromH,
        toH: toH,
      );
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .doc(trainer.uid)
          .update(
            model.toJson(),
          );
      List<TrainerModel> list = await trainerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TrainerModel>>> updateGallery({
    required TrainerModel trainer,
    required String imgBefore,
    required String imgAfter,
  }) async {
    try {
      List<GalleryModel> gallery = trainer.gallery;
      List files = [];
      files.add(File(imgBefore));
      files.add(File(imgAfter));
      List<String> imgs = await uploadFiles(files: files);

      GalleryModel model = GalleryModel(
        before: imgs.first,
        after: imgs.last,
        createdAt: Timestamp.now(),
      );
      gallery.add(model);
      TrainerModel newmodel = TrainerModel(
        isBanned: trainer.isBanned,
        description: trainer.description,
        isRequestProfits: trainer.isRequestProfits,
        uid: trainer.uid,
        profits: trainer.profits,
        questionsTrainees: trainer.questionsTrainees,
        price: trainer.price,
        traineesCount: trainer.traineesCount,
        gallery: gallery,
        fromH: trainer.fromH,
        toH: trainer.toH,
      );
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .doc(trainer.uid)
          .update(
            newmodel.toJson(),
          );
      List<TrainerModel> list = await trainerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TrainerModel>>> removeGallery({
    required TrainerModel trainer,
    required GalleryModel model,
  }) async {
    try {
      List<GalleryModel> gallery = trainer.gallery;
      gallery.remove(model);
      List<String> oldImages = [];
      oldImages.add(model.before);
      oldImages.add(model.after);
      await deleteOldImages(newImages: [], oldImages: oldImages);
      TrainerModel newmodel = TrainerModel(
        isBanned: trainer.isBanned,
        isRequestProfits: trainer.isRequestProfits,
        description: trainer.description,
        profits: trainer.profits,
        questionsTrainees: trainer.questionsTrainees,
        uid: trainer.uid,
        price: trainer.price,
        traineesCount: trainer.traineesCount,
        gallery: gallery,
        fromH: trainer.fromH,
        toH: trainer.toH,
      );
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .doc(trainer.uid)
          .update(
            newmodel.toJson(),
          );
      List<TrainerModel> list = await trainerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification({
    required bool isBanned,
    required String trainerId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'trainer',
      senderUid: adminUid,
      title: isBanned == true ? 'ban_trainer' : 'no_ban_trainer',
      body: '',
      type: 'notification',
      uid: trainerId,
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
        title: 'مرحبا كوتش',
        body: isBanned == false
            ? 'عزيزي المدرب، تم رفع الحظر من قبل المدير'
            : 'عزيزي المدرب، نأسف لإبلاغك بأن حسابك قد تم حظره من قبل المدير. إذا كان لديك أي أسئلة أو استفسارات، يرجى التواصل مع فريق الدعم الخاص بنا للحصول على المساعدة اللازمة',
        data: {
          "type": "notification",
          "subType": "trainer",
          "uid": trainerId,
        },
      );
    }
  }

  @override
  Future<Either<String, List<TrainerModel>>> addNewQuestion({
    required TrainerModel trainer,
    required String question,
  }) async {
    try {
      List<String> questions = trainer.questionsTrainees;
      questions.add(question);
      TrainerModel newmodel = TrainerModel(
        isBanned: trainer.isBanned,
        description: trainer.description,
        isRequestProfits: trainer.isRequestProfits,
        uid: trainer.uid,
        profits: trainer.profits,
        questionsTrainees: questions,
        price: trainer.price,
        traineesCount: trainer.traineesCount,
        gallery: trainer.gallery,
        fromH: trainer.fromH,
        toH: trainer.toH,
      );
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .doc(trainer.uid)
          .update(
            newmodel.toJson(),
          );
      List<TrainerModel> list = await trainerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TrainerModel>>> removeQuestion({
    required TrainerModel trainer,
    required String question,
  }) async {
    try {
      List<String> questions = trainer.questionsTrainees;
      questions.remove(question);
      TrainerModel newmodel = TrainerModel(
        isBanned: trainer.isBanned,
        description: trainer.description,
        uid: trainer.uid,
        isRequestProfits: trainer.isRequestProfits,
        profits: trainer.profits,
        questionsTrainees: questions,
        price: trainer.price,
        traineesCount: trainer.traineesCount,
        gallery: trainer.gallery,
        fromH: trainer.fromH,
        toH: trainer.toH,
      );
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .doc(trainer.uid)
          .update(
            newmodel.toJson(),
          );
      List<TrainerModel> list = await trainerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
