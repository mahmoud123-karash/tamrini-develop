import 'package:dartz/dartz.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/admin/data/remote_data_source/admin_remote_data_source.dart';
import 'package:tamrini/features/admin/domain/repo/admin_repo.dart';

class AdminRepoImpl extends AdminRepo {
  final AdminRemoteDataSource adminRemoteDataSource;

  AdminRepoImpl(this.adminRemoteDataSource);
  @override
  Future<Either<String, List<UserModel>>> getUsers() async {
    try {
      List<UserModel> list = await adminRemoteDataSource.getUsers();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
