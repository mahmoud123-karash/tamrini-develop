import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
import 'package:tamrini/features/auth/domain/repo/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final UserRemoteDataSource userRemoteDataSource;

  LoginRepoImpl(this.userRemoteDataSource);
  @override
  Future<Either<String, String>> loginwithEmailAndPass({
    required String email,
    required String password,
  }) async {
    try {
      var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user!.emailVerified) {
        UserModel model = await userRemoteDataSource.get(uid: user.user!.uid);
        saveUserType(model.role);
        saveTrainerId(model.trainerId);
        return right(user.user!.uid);
      } else {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        return left('Not');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.code);
    }
  }

  @override
  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return user;
  }
}
