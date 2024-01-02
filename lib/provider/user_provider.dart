import 'dart:async';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamrini/data/user_data.dart';
import 'package:tamrini/model/user.dart';
import 'package:tamrini/screens/Home_screen.dart';
import 'package:tamrini/screens/login_screen/complete_register_screen.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../screens/login_screen/login_screen.dart';
import '../screens/notifications_screen.dart';
import '../utils/cache_helper.dart';

class UserProvider with ChangeNotifier {
  late User _user = User(
      name: "",
      email: "",
      phone: "",
      role: "",
      isBanned: false,
      isVerifiedPhoneNumber: false,
      notification: false,
      notifications: [],
      username: '',
      password: '',
      token: '',
      uid: '',
      gender: '',
      age: 0,
      isSubscribedToTrainer: false,
      isVerifiedEmail: false,
      pendingEmail: '');
  UserData userData = UserData();
  bool isLogin = false;
  bool isAdmin = false;
  bool isCaptain = false;
  String verificationId = "";
  String credentialsName = "";
  String credentialsEmail = "";

  User get user => _user;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userSnapshot;

  void _setUser(User user) {
    _user = user;
    if (user.isBanned) {
      Fluttertoast.showToast(msg: "You are banned");
      CacheHelper.putBoolean(key: 'isLogin', value: false);
      ToAndFinish(const LoginScreen());
    }
    isAdmin = user.role == 'admin' ? true : false;
    isCaptain = user.role == 'captain' ? true : false;
    CacheHelper.putBoolean(key: 'isLogin', value: true);
    isLogin = CacheHelper.getBoolean(key: "isLogin");
    notifyListeners();
  }

  initiate() async {
    debugPrint('----- initiate -------');
    isLogin = CacheHelper.getBoolean(key: "isLogin");
    await _userSnapshot?.cancel();
    if (CacheHelper.getString(key: "id").isNotEmpty) {
      _userSnapshot = FirebaseFirestore.instance
          .collection('users')
          .doc(CacheHelper.getString(key: "id") ?? "")
          .snapshots()
          .listen((event) {
        if (isLogin == false) {
          _userSnapshot!.cancel();
          return;
        }
        if (event.exists) {
          _setUser(User.fromMap(event.data()!, event.id));
        } else {
          Navigator.push(
            navigationKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
      });

      // auth.FirebaseAuth.instance.userChanges().listen((auth.User? user) async {
      //   print("user changes");
      //   // print(user!.emailVerified.toString());
      //   if (user == null) {
      //     print('User is currently signed out!');
      //   } else {
      //     if (user.emailVerified) {
      //       if (user.email != _user.email) {
      //         await FirebaseFirestore.instance
      //             .collection('users')
      //             .doc(user.uid)
      //             .update({'email': user.email});
      //         _setUser(_user.copyWith(email: user.email));
      //         AwesomeDialog(
      //           context: navigationKey.currentContext!,
      //           dialogType: DialogType.SUCCES,
      //           animType: AnimType.BOTTOMSLIDE,
      //           title: 'تم تغيير البريد الالكتروني',
      //           desc: 'تم تغيير البريد الالكتروني الخاص بك بنجاح',
      //           btnOkOnPress: () {
      //             Navigator.push(
      //               navigationKey.currentContext!,
      //               MaterialPageRoute(
      //                 builder: (context) => LoginScreen(),
      //               ),
      //             );
      //           },
      //         ).show();
      //       }
      //       await FirebaseFirestore.instance
      //           .collection('users')
      //           .doc(user.uid)
      //           .update({'isVerifiedEmail': true});
      //       _setUser(_user.copyWith(isEmail: true));
      //     }
      //   }
      // });
    }
    _startEmailVerificationTimer();
    notifyListeners();
  }

  _startEmailVerificationTimer() {
    print("cecking email  verification");
    var timer = Timer.periodic(Duration(seconds: 5), (Timer _) async {
      if (auth.FirebaseAuth.instance.currentUser == null &&
          _user.pendingEmail.isNotEmpty &&
          _user.password.isNotEmpty) {
        await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _user.pendingEmail, password: _user.password);
      }
      if (isLogin) {
        await auth.FirebaseAuth.instance.currentUser?.reload();
        if (auth.FirebaseAuth.instance.currentUser?.emailVerified == true &&
            _user.isVerifiedEmail == false) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(auth.FirebaseAuth.instance.currentUser!.uid)
              .update({'isVerifiedEmail': true});
        }
        if (_user.email != auth.FirebaseAuth.instance.currentUser!.email &&
            auth.FirebaseAuth.instance.currentUser!.emailVerified) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(auth.FirebaseAuth.instance.currentUser!.uid)
              .update({
            'email': auth.FirebaseAuth.instance.currentUser!.email,
            'isVerifiedEmail': true
          });
        }
      }
    });
  }

  logIn({required String email, required String password}) async {
    showLoaderDialog(navigationKey.currentContext!);

    try {
      _setUser(await userData.logInWithEmail(
        email: email,
        password: password,
      ));

      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('name', user.name);
        prefs.setString('email', user.email);
        prefs.setString('phone', user.phone);
        prefs.setString('username', user.username);
        prefs.setString('role', user.role);
        prefs.setString('id', user.uid);
        prefs.setInt('age', user.age);
        prefs.setString('gender', user.gender);
      });
      setRole();

      initiate();
      pop();
      ToAndFinish(const HomeScreen());
    } catch (e) {
      print(e);
      try {
        catcherHandler(e as AuthCatch);
      } catch (e) {
        pop();
        Fluttertoast.showToast(msg: "حدث خطأ ما");
      }
    }
  }

  signUp(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String username,
      required String role,
      required int age,
      required String gender}) async {
    showLoaderDialog(navigationKey.currentContext!);

    try {
      // verifyPhone(phone: "+2$phone");
      _setUser(await userData.signUp(
          name: name,
          email: email,
          phone: phone,
          password: password,
          username: username,
          age: age,
          gender: gender));
      CacheHelper.putBoolean(key: 'isLogin', value: true);

      setRole();
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('name', user.name);
        prefs.setString('email', user.email);
        prefs.setString('phone', user.phone);
        prefs.setString('username', user.username);
        prefs.setString('role', user.role);
        prefs.setString('id', user.uid);
        prefs.setString('gender', user.gender);
        prefs.setInt('age', user.age);
      });
      initiate();
      pop();
      pop();

      ToAndFinish(const HomeScreen());
    } catch (e) {
      log("from provider" + e.toString());

      catcherHandler(e);
    }
  }

  catcherHandler(dynamic authCatch) {
    pop();
    if (authCatch == AuthCatch.existPhone) {
      Fluttertoast.showToast(msg: 'هذا الرقم مسجل مسبقا');
    } else if (authCatch == AuthCatch.emailAlreadyInUse) {
      Fluttertoast.showToast(msg: 'هذا البريد مسجل مسبقا');
    } else if (authCatch == AuthCatch.wrongEmailOrPass) {
      Fluttertoast.showToast(msg: 'البريد الالكتروني او كلمة المرور غير صحيحة');
    } else if (authCatch == AuthCatch.weakPassword) {
      Fluttertoast.showToast(msg: 'كلمة المرور ضعيفة');
    } else if (authCatch == AuthCatch.userNotFound) {
      Fluttertoast.showToast(msg: 'المستخدم غير موجود');
    } else if (authCatch == AuthCatch.wrongPassword) {
      Fluttertoast.showToast(msg: 'كلمة المرور غير صحيحة');
    } else if (authCatch == AuthCatch.networkError) {
      Fluttertoast.showToast(msg: 'خطأ في الشبكة');
    } else if (authCatch == AuthCatch.emailAlreadyInUse) {
      Fluttertoast.showToast(msg: 'البريد الالكتروني مسجل مسبقا');
    } else if (authCatch == AuthCatch.invalidEmail) {
      Fluttertoast.showToast(msg: 'البريد الالكتروني غير صحيح');
    } else if (authCatch == AuthCatch.userDisabled) {
      Fluttertoast.showToast(msg: 'المستخدم معطل');
    } else if (authCatch == AuthCatch.unknown) {
      Fluttertoast.showToast(msg: 'خطأ غير معروف');
    } else if (authCatch == AuthCatch.invalidCredential) {
      Fluttertoast.showToast(msg: 'بيانات الدخول غير صحيحة');
    } else if (authCatch == AuthCatch.invalidPhone) {
      Fluttertoast.showToast(msg: 'رقم الهاتف غير صحيح');
    } else if (authCatch == AuthCatch.phoneAlreadyInUse) {
      Fluttertoast.showToast(msg: 'رقم الهاتف مسجل مسبقا');
    } else if (authCatch == AuthCatch.tooManyRequests) {
      Fluttertoast.showToast(msg: 'العدد المسموح به من محاولات الدخول');
    } else if (authCatch == AuthCatch.operationNotAllowed) {
      Fluttertoast.showToast(msg: 'العملية غير مسموح بها');
    } else if (authCatch == AuthCatch.accountExistsWithDifferentCredential) {
      Fluttertoast.showToast(msg: 'الحساب مسجل مسبقا');
    } else if (authCatch == AuthCatch.credentialAlreadyInUse) {
      Fluttertoast.showToast(msg: 'البيانات مسجلة مسبقا');
    } else if (authCatch == AuthCatch.invalidVerificationCode) {
      Fluttertoast.showToast(msg: 'كود التحقق غير صحيح');
    } else if (authCatch == AuthCatch.invalidVerificationId) {
      Fluttertoast.showToast(msg: 'كود التحقق غير صحيح');
    } else if (authCatch == AuthCatch.sessionExpired) {
      Fluttertoast.showToast(msg: 'انتهت صلاحية الدخول');
    } else if (authCatch == AuthCatch.missingVerificationCode) {
      Fluttertoast.showToast(msg: 'كود التحقق مفقود');
    } else if (authCatch == AuthCatch.missingVerificationId) {
      Fluttertoast.showToast(msg: 'كود التحقق مفقود');
    } else if (authCatch == AuthCatch.quotaExceeded) {
      Fluttertoast.showToast(msg: 'تم تجاوز الحد المسموح به');
    } else if (authCatch == AuthCatch.captchaCheckFailed) {
      Fluttertoast.showToast(msg: 'فشل التحقق من الكابتشا');
    } else if (authCatch == AuthCatch.invalidAppCredential) {
      Fluttertoast.showToast(msg: 'بيانات الدخول غير صحيحة');
    } else if (authCatch == AuthCatch.existUsername) {
      Fluttertoast.showToast(msg: 'اسم المستخدم مسجل مسبقا');
    } else if (authCatch == AuthCatch.emailIsNotVerified) {
      Fluttertoast.showToast(msg: 'البريد الالكتروني غير مفعل');
    } else {
      Fluttertoast.showToast(msg: 'خطأ غير معروف');
    }
  }

  openNotifications() {
    To(NotificationPage());
    try {
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'notification': false,
      });
    } catch (e) {
      print(e);
    }
  }

  setRole() {
    if (user.role == 'admin') {
      isAdmin = true;
      isCaptain = false;
    } else if (user.role == 'captain') {
      isCaptain = true;
      isAdmin = false;
    } else {
      isCaptain = false;
      isAdmin = false;
    }
    notifyListeners();
  }

  logOut() async {
    try {
      SharedPreferences.getInstance().then((prefs) async {
        await userData.logOut();
        _userSnapshot!.cancel();
        prefs.remove('name');
        prefs.remove('email');
        prefs.remove('phone');
        prefs.remove('username');
        prefs.remove('role');
        prefs.remove('age');
        prefs.remove('gender');

        CacheHelper.putBoolean(key: 'isLogin', value: false);
        isLogin = false;
        ToAndFinish(const LoginScreen());
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  editUserData(String name) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'name': name}).then((value) {
        user.name = name;
        _setUser(user);
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'تم التعديل بنجاح',
          desc: 'تم تعديل بياناتك بنجاح',
          btnOkOnPress: () {
            Navigator.pop(navigationKey.currentContext!);
          },
        ).show().then((value) => ToAndFinish(const HomeScreen()));
      });
    } catch (e) {
      print(e);
    }
  }

  logInWithApple() async {
    try {
      showLoaderDialog(navigationKey.currentContext!);

      var data = await userData.logInWithApple();

      if (data.age == 0) {
        credentialsEmail = data.email;
        credentialsName = data.name;

        To(CompleteRegisterScreen(
          email: credentialsEmail,
          name: credentialsName,
          isApple: true,
        ));
        notifyListeners();
        return;
      }

      _setUser(data);
      setRole();

      await SharedPreferences.getInstance().then((prefs) {
        prefs.setString('name', user.name);
        prefs.setString('email', user.email);
        prefs.setString('phone', user.phone);
        prefs.setString('username', user.username);
        prefs.setString('role', user.role);
        prefs.setString('id', user.uid);
        prefs.setInt('age', user.age);
        prefs.setString('gender', user.gender);
        CacheHelper.putBoolean(key: 'isLogin', value: true);
      });

      initiate();
      pop();
      ToAndFinish(const HomeScreen());
    } catch (e) {
      log(e.toString());

      catcherHandler(e as AuthCatch);
    }
  }

  logInWithGoogle() async {
    try {
      showLoaderDialog(navigationKey.currentContext!);

      var data = await userData.logInWithGoogle();

      if (data.age == 0) {
        credentialsEmail = data.email;
        credentialsName = data.name;

        To(CompleteRegisterScreen(
          email: credentialsEmail,
          name: credentialsName,
        ));

        notifyListeners();
        return;
      }

      _setUser(data);
      setRole();

      await SharedPreferences.getInstance().then((prefs) {
        prefs.setString('name', user.name);
        prefs.setString('email', user.email);
        prefs.setString('phone', user.phone);
        prefs.setString('username', user.username);
        prefs.setString('role', user.role);
        prefs.setString('id', user.uid);
        prefs.setInt('age', user.age);
        prefs.setString('gender', user.gender);

        CacheHelper.putBoolean(key: 'isLogin', value: true);
      });

      initiate();
      pop();
      ToAndFinish(const HomeScreen());
    } catch (e) {
      log(e.toString());

      catcherHandler(e as AuthCatch);
    }
  }

  deleteAccount() async {
    try {
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'هل انت متأكد من حذف الحساب؟',
        desc: 'سيتم حذف الحساب بشكل نهائي',
        btnOkOnPress: () async {
          // re enter password to delete account
          final passwordController = TextEditingController();
          AwesomeDialog(
            context: navigationKey.currentContext!,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: 'ادخل كلمة المرور',
            desc: 'لتأكيد حذف الحساب',
            body: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'كلمة المرور',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            btnOkOnPress: () async {
              if (passwordController.text.isEmpty) {
                Fluttertoast.showToast(msg: 'ادخل كلمة المرور');
                return;
              }

              if (passwordController.text != user.password) {
                Fluttertoast.showToast(msg: 'كلمة المرور غير صحيحة');
                return;
              }

              await userData.logInWithEmail(
                  email: user.email, password: user.password);

              await userData.deleteAccount();

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .delete();
              logOut();

              ToAndFinish(const LoginScreen());
            },
            btnOkColor: Colors.green,
            btnOkText: 'تأكيد',
          ).show();
        },
        btnOkColor: Colors.green,
        btnOkText: 'نعم',
        btnCancelText: 'لا',
        btnCancelColor: Colors.red,
        btnCancelOnPress: () {},
      ).show();
    } catch (e) {
      print(e);
    }
  }

  changePassword(String newPassword) async {
    try {
      log(newPassword);
      showLoaderDialog(navigationKey.currentContext!);
      await userData.logInWithEmail(email: user.email, password: user.password);
      await userData.updatePassword(newPassword);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'password': newPassword,
      });

      pop();

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'تم التعديل بنجاح',
        desc: 'تم تعديل كلمة المرور بنجاح',
        btnOkOnPress: () {
          Navigator.pop(navigationKey.currentContext!);
        },
      ).show().then((value) => To(const HomeScreen()));
    } catch (e) {
      pop();
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'حدث خطأ',
        desc:
            'حدث خطأ اثناء تعديل كلمة المرور , الرجاء استخدام (نسيت كلمة المرور) عند التسجيل',
        btnOkOnPress: () {
          Navigator.pop(navigationKey.currentContext!);
        },
      ).show();
      print(e);
      catcherHandler(e as AuthCatch);
    }
  }

  changeEmail(String newEmail) async {
    try {
      showLoaderDialog(navigationKey.currentContext!);
      await userData.updateEmail(newEmail, user.uid, user.password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.FirebaseAuth.instance.currentUser!.uid)
          .update({
        'pendingEmail': newEmail,
      });
      _user.pendingEmail = newEmail;
    } catch (e) {
      print(e);

      catcherHandler(e as AuthCatch);
    }
  }

  verifyEmail() async {
    try {
      await userData.verifyEmail();

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: 'تم ارسال رسالة التحقق',
        desc: 'تم ارسال رسالة التحقق الى بريدك الالكتروني',
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      print(e);
      catcherHandler(e as AuthCatch);
    }
  }

  verifyPhone({required String phoneNumber}) async {
    try {
      showLoaderDialog(navigationKey.currentContext!);

      // verify for unique phone number
      await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phoneNumber)
          .get()
          .then((value) {
        if (user.phone == phoneNumber) {
          return;
        }
        if (value.docs.isNotEmpty) {
          throw AuthCatch.phoneAlreadyInUse;
        }
      });
      // pop();
      await userData.verifyPhone(phoneNumber);
    } catch (e) {
      print(e);
      catcherHandler(e as AuthCatch);
    }
  }

  verifyPhoneCode({required String code, String? phone}) async {
    try {
      await userData.verifyCode(code, phone: phone);
      pop();

      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'تم التحقق بنجاح',
        desc: 'تم تحقق من رقم الهاتف بنجاح',
      ).show().then((value) {
        ToAndFinish(const HomeScreen());
      });
    } catch (e) {
      if (e as AuthCatch == AuthCatch.invalidCode) {
        pop();
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'رمز التحقق غير صحيح',
        ).show().then((value) => pop());
      } else if (e as AuthCatch == AuthCatch.invalidPhone) {
        pop();
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'رقم الهاتف غير صحيح',
        ).show().then((value) => pop());
      } else if (e as AuthCatch == AuthCatch.phoneAlreadyInUse) {
        pop();
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'خطأ',
          desc: 'رقم الهاتف مستخدم من قبل',
        ).show().then((value) => pop());
      } else {
        catcherHandler(e as AuthCatch);
      }
    }
  }

  forgetPassword(String email) async {
    try {
      if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
        throw AuthCatch.invalidEmail;
      }
      showLoaderDialog(navigationKey.currentContext!);
      await userData.forgetPassword(email);
      pop();
      AwesomeDialog(
        context: navigationKey.currentContext!,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'تم ارسال رابط استعادة كلمة المرور',
        desc: 'تم ارسال رابط استعادة كلمة المرور الى بريدك الالكتروني',
        btnOkOnPress: () {
          Navigator.pop(navigationKey.currentContext!);
        },
      ).show();
    } catch (e) {
      print(e);
      catcherHandler(e as AuthCatch);
    }
  }

  // delete notification
  deleteNotification(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'notifications': FieldValue.arrayRemove([id])
      });
    } catch (e) {
      print(e);
    }
  }
}
