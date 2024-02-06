import 'package:dartz/dartz.dart';
import 'package:tamrini/features/auth/domain/repo/register_repo.dart';

abstract class UseCase {
  Future<Either<String, String>> signUp({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String password,
  });
}

class RegisterUseCase extends UseCase {
  final RegisterRepo registerRepo;

  RegisterUseCase(this.registerRepo);
  @override
  Future<Either<String, String>> signUp({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    try {
      String uid = await registerRepo.signUp(email: email, password: password);
      registerRepo.createUser(
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        uid: uid,
      );

      return right('created');
    } catch (e) {
      return left(e.toString());
    }
  }
}
