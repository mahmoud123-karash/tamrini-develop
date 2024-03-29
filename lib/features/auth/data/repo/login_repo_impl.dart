import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
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

  @override
  Future<Either<String, String>> deleteAccount() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        user.delete();
        String uid = CacheHelper.getData(key: 'uid') ?? '';
        await FirebaseFirestore.instance.collection('users').doc(uid).update(
          {
            'isDeleted': true,
            "email": '',
          },
        );
        return right('r');
      } else {
        return right('re');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        return right('re');
      } else {
        return left(e.code);
      }
    }
  }

  @override
  Future<UserCredential> loginWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final AuthCredential appleAuthCredential =
        OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: Platform.isIOS ? null : appleCredential.authorizationCode,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);

    return userCredential;
  }
}
