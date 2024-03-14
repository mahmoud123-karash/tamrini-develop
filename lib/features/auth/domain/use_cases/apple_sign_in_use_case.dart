import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
import 'package:tamrini/features/auth/domain/entities/user_entity.dart';
import 'package:tamrini/features/auth/domain/repo/login_repo.dart';

abstract class UseCase {
  Future<Either<String, UserEntity>> appleSignIn();
}

class AppleSignInUseCase extends UseCase {
  final LoginRepo loginRepo;

  AppleSignInUseCase(this.loginRepo);
  @override
  Future<Either<String, UserEntity>> appleSignIn() async {
    try {
      UserCredential user = await loginRepo.loginWithApple();
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .get();
      if (result.data() != null) {
        UserModel model = UserModel.fromMap(result.data()!);
        saveUserType(model.role);
        saveTrainerId(model.trainerId);
        return right(
          UserEntity(
            email: user.user!.email!,
            name: user.user!.displayName!,
            uid: user.user!.uid,
            isCreated: true,
          ),
        );
      } else {
        return right(
          UserEntity(
            email: user.user!.email!,
            name: user.user!.displayName!,
            uid: user.user!.uid,
            isCreated: false,
          ),
        );
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
