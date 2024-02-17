import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/banner/data/data_sources/remote_data_source/banner_remote_data_source.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';
import 'package:tamrini/features/banner/domain/repo/banner_repo.dart';
import 'package:uuid/uuid.dart';

class BannerRepoImpl extends BannerRepo {
  final BannerRemoteDataSource bannerRemoteDataSource;

  BannerRepoImpl(this.bannerRemoteDataSource);
  @override
  Future<Either<String, List<BannerModel>>> getBanners() async {
    try {
      List<BannerModel> list = await bannerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BannerModel>>> addBanner({
    required String uri,
    required String imagePath,
  }) async {
    try {
      var uuid = const Uuid().v4();
      List files = [];
      files.add(File(imagePath));
      List<String> images = await uploadFiles(files: files);
      BannerModel model = BannerModel(
        id: uuid,
        image: images.isEmpty ? '' : images.first,
        uri: uri,
        addedAt: Timestamp.now(),
      );
      await FirebaseFirestore.instance.collection('banners').doc(uuid).set(
            model.toJson(),
          );
      List<BannerModel> list = await bannerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BannerModel>>> removeBanner({
    required String id,
    required String image,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('banners').doc(id).delete();
      List<BannerModel> list = await bannerRemoteDataSource.get();
      List<String> oldImages = [];
      oldImages.add(image);
      await deleteOldImages(newImages: [], oldImages: oldImages);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
