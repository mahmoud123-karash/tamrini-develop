import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepo {
  Future<Either<String, String>> loginwithEmailAndPass({
    required String email,
    required String password,
  });

  Future<UserCredential> loginWithGoogle();
  Future<Either<String, String>> deleteAccount();
}
