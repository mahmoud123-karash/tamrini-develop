import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/trainer/data/data_sources/remote_data_source/trainer_remote_data_source.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/gallery_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/domain/repo/trainer_repo.dart';

class TrainerRepoImpl extends TrainerRepo {
  final TrainerRemoteDataSource trainerRemoteDataSource;

  TrainerRepoImpl(this.trainerRemoteDataSource);
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
        uid: trainer.uid,
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
        description: trainer.description,
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
}
