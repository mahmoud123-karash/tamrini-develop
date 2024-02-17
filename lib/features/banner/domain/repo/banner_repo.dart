import 'package:dartz/dartz.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';

abstract class BannerRepo {
  Future<Either<String, List<BannerModel>>> getBanners();
  Future<Either<String, List<BannerModel>>> addBanner({
    required String uri,
    required String imagePath,
  });
  Future<Either<String, List<BannerModel>>> removeBanner({
    required String id,
  });
}
