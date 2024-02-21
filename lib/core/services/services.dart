import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/rating_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../features/auth/presentation/views/login_screen.dart';

void openUri({required Uri url}) async {
  await launchUrl(url).then((value) {
    if (kDebugMode) {
      print(value);
    }
  });
}

Future<void> share({
  required String title,
  required String text,
}) async {
  await FlutterShare.share(
    title: title,
    text: text,
    linkUrl: appLink,
  );
}

double calculateAverageRating(List<Rating> ratings) {
  if (ratings.isEmpty) {
    return 0.0;
  }
  double sum = 0.0;
  for (Rating rating in ratings) {
    sum += rating.rating;
  }
  double average = sum / ratings.length;
  return average;
}

Future showAppBottomSheet(
  context,
  widget, {
  bool isDismissible = true,
}) {
  return showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 0.9,
    context: context,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    useRootNavigator: isDismissible,
    constraints: const BoxConstraints(),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (context) => widget,
  );
}

String formatTimeDifference(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks week${weeks > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  }
}

String formatTimeDifferenceInArabic(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'الآن';
  } else if (difference.inMinutes < 60) {
    return 'منذ ${difference.inMinutes} دقائق';
  } else if (difference.inHours < 24) {
    return 'منذ ${difference.inHours} ساعات';
  } else if (difference.inDays < 7) {
    return 'منذ ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return 'منذ $weeks ${weeks == 1 ? 'أسبوع' : 'أسابيع'}';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return 'منذ $months ${months > 1 ? 'أ' : ''}شهر';
  } else {
    final years = (difference.inDays / 365).floor();
    return 'منذ $years ${years == 1 ? 'ًسنة' : 'سنوات'}';
  }
}

void initiGetprofile(context) {
  var box = Hive.box<ProfileModel>(profileBox);
  if (box.values.isEmpty) {
    ProfileCubit.get(context).getProfile();
  }
}

void logOut(context) async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  if (await googleSignIn.isSignedIn()) {
    googleSignIn.disconnect();
  }
  await FirebaseAuth.instance.signOut();
  navigateToAndFinish(context, const LoginScreen());
  String uid = CacheHelper.getData(key: 'uid') ?? '';
  if (uid != '') {
    await FirebaseFirestore.instance.collection('users').doc(uid).update(
      {
        'token': "",
      },
    );
  }
  var box = Hive.box<ProfileModel>(profileBox);
  await box.clear();
  var box1 = Hive.box<DayModel>(dayBox);
  await box1.clear();
  var box2 = Hive.box<MealModel>(favoriteBox);
  await box2.clear();
  clearSubBox();
  CacheHelper.removeData(key: 'deviceToken');
  CacheHelper.removeData(key: 'trainerId');
  CacheHelper.removeData(key: 'address');
  CacheHelper.removeData(key: 'uid');
}

void showReminderBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      borderSide: BorderSide.none,
    ),
    builder: (context) => widget,
  );
}

bool isTimeAfter(DateTime givenTime) {
  final currentDateTime = DateTime.now();
  return givenTime.isAfter(currentDateTime);
}

DateTime nextScheduledDate(hour, minute) {
  final DateTime now = DateTime.now();
  DateTime scheduledDate = DateTime(
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

String formatNumber(int number) {
  final formatter = NumberFormat.compact(
    locale: Intl.getCurrentLocale(),
  );
  return formatter.format(number);
}

void clearSubBox() async {
  var box = Hive.box<SubscriptionModel>(subBox);
  await box.clear();
}

String getEnlish() {
  String lang = Platform.localeName;
  if (lang == 'en_US' ||
      lang == 'en_I' ||
      lang == 'en_NZ' ||
      lang == 'en_UK' ||
      lang == 'en_A') {
    return 'en';
  } else {
    return 'ar';
  }
}

Future<UserModel> getUser(
  String uid,
) async {
  var result =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  GeoPoint defultLocation = const GeoPoint(33.312805, 44.361488);
  GeoPoint location = result.data() == null
      ? defultLocation
      : result.data()!['location'] ?? defultLocation;
  String address = await getAddress(location: location);
  UserModel user = UserModel.fromMap(result.data()!, result.id, address);
  return user;
}
