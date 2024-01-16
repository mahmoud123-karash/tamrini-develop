import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/domain/repo/profile_repo.dart';

abstract class UseCase {
  Future<Either<String, ProfileModel>> update({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String phone,
    required String image,
    required bool isBanned,
    required String facebookUri,
    required String instgramUri,
    required String twiterUri,
    required String address,
  });
}

class UpdateUseCase extends UseCase {
  final ProfileRepo profileRepo;

  UpdateUseCase(this.profileRepo);
  @override
  Future<Either<String, ProfileModel>> update({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String phone,
    required String image,
    required bool isBanned,
    required String facebookUri,
    required String instgramUri,
    required String twiterUri,
    required String address,
  }) async {
    try {
      var box = Hive.box<ProfileModel>(profileBox);
      await box.clear();
      String path = CacheHelper.getData(key: 'imagepath') ?? '';
      ProfileModel model(String img) => ProfileModel(
            name: name,
            facebookUri: facebookUri,
            instgramUri: instgramUri,
            twiterUri: twiterUri,
            email: email,
            phone: phone,
            gender: gender,
            image: img,
            age: age,
            isBanned: isBanned,
            address: address,
          );
      if (path == '') {
        profileRepo.updateProfile(
          model: model(image),
        );
        box.add(model(image));
        return right(model(image));
      } else {
        if (image != '') {
          profileRepo.removeOldProfileImage(imagePath: image);
        }
        String uri = await profileRepo.uploadImge(
          imageFile: File(path),
        );
        profileRepo.updateProfile(
          model: model(uri),
        );
        box.add(model(uri));
        return right(model(uri));
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
