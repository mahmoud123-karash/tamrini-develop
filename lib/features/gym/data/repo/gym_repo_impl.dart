import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/gym/data/data_sources/remote_data_source/gym_remote_data_source.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/domain/repo/gym_repo.dart';

class GymRepoImpl extends GymRepo {
  final GymRemoteDataSource gymRemoteDataSource;

  GymRepoImpl(this.gymRemoteDataSource);

  @override
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  }) async {
    return await gymRemoteDataSource.getGyms(update: update);
  }

  @override
  Future<Either<String, List<GymModel>>> addGym({
    required List<String> paths,
    required String name,
    required String description,
    required int price,
    required double lat,
    required double long,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      List files = [];
      for (var element in paths) {
        files.add(File(element));
      }
      List<String> assets = await uploadFiles(files: files);
      GymModel model = GymModel(
        assets: assets,
        name: name,
        location: GeoPoint(lat, long),
        price: price,
        id: '',
        description: description,
        distance: 0,
        ownerUid: uid,
        isBanned: false,
      );
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .add(
            model.toJson(),
          );
      return await gymRemoteDataSource.getGyms(update: false);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<GymModel>>> editGym() {
    // TODO: implement editGym
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<GymModel>>> removeGym({
    required String id,
    required List<String> images,
  }) async {
    try {
      await deleteOldImages(newImages: [], oldImages: images);
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(id)
          .delete();
      return await gymRemoteDataSource.getGyms(update: false);
    } catch (e) {
      return left(e.toString());
    }
  }
}
