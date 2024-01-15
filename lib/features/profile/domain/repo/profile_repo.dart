import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<String, ProfileModel>> getProfile();
  void updateProfile({required ProfileModel model});
  Future<Either<String, XFile>> pickProfileImage();
  void removeOldProfileImage({required String imagePath});
  Future<String> uploadImge({required File imageFile});
}
