import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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
        return right(user.user!.uid);
      } else {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        return left('Not');
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<UserCredential> loginUserWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final AuthCredential appleAuthCredential =
        OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
      accessToken: Platform.isIOS ? null : appleCredential.authorizationCode,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);

    return userCredential;
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
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
