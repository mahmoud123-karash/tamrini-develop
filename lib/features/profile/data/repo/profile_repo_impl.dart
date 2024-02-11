import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/profile/data/data_sources/local_data_source/profile_local_data_source.dart';
import 'package:tamrini/features/profile/data/data_sources/remote_data_source/profile_remote_data_source.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemotedataSource profileRemotedataSource;
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileRepoImpl(this.profileRemotedataSource, this.profileLocalDataSource);
  @override
  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      List<ProfileModel> list = profileLocalDataSource.get();
      if (list.isNotEmpty) {
        return right(list.first);
      } else {
        ProfileModel model = await profileRemotedataSource.get();
        saveTrainerId(model.trainerId);
        return right(model);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  void updateProfile({required ProfileModel model}) {
    String uid = CacheHelper.getData(key: 'uid');
    FirebaseFirestore.instance.collection('users').doc(uid).update(
          model.toMap(),
        );
  }
}
