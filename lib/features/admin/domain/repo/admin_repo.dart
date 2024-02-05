import 'package:dartz/dartz.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';

abstract class AdminRepo {
  Future<Either<String, List<UserModel>>> getUsers();
}
