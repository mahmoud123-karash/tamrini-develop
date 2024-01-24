import 'package:dartz/dartz.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<String, ProfileModel>> getProfile();
  void updateProfile({required ProfileModel model});
}
