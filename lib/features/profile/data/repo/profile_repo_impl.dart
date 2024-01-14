import 'package:dartz/dartz.dart';
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
        return right(model);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
