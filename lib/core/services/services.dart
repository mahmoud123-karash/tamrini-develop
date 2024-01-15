import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart'
    as user;

import 'package:tamrini/features/trainer/data/models/trainer_model/rating_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share/flutter_share.dart';

void getUserType(UserModel model) {
  if (model.isSubscribedToTrainer) {
    saveUserType('trainer');
  } else if (model.isSubscribedToStoreOwner) {
    saveUserType('storeOwner');
  } else if (model.isSubscribedToGymOwner) {
    saveUserType('gymOwner');
  } else if (model.isSubscribedToPublisher) {
    saveUserType('publisher');
  } else if (model.admin) {
    saveUserType('admin');
  } else {
    saveUserType('user');
  }
}

String getQuestionUserType(user.UserModel model) {
  if (model.isSubscribedToTrainer) {
    return 'trainer';
  } else if (model.isSubscribedToStoreOwner) {
    return 'storeOwner';
  } else if (model.isSubscribedToGymOwner) {
    return 'gymOwner';
  } else if (model.isSubscribedToPiblisher) {
    return 'publisher';
  } else if (model.admin) {
    return 'admin';
  } else {
    return 'user';
  }
}

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
    final format = DateFormat('منذ mm دقائق');
    return format.format(dateTime);
  } else if (difference.inHours < 24) {
    final format = DateFormat('منذ HH ساعات');
    return format.format(dateTime);
  } else if (difference.inDays < 7) {
    final format = DateFormat('EEEE', 'ar');
    return format.format(dateTime);
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    final format = DateFormat('منذ $weeks أسابيع');
    return format.format(dateTime);
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    final format = DateFormat('منذ $months أشهر');
    return format.format(dateTime);
  } else {
    final years = (difference.inDays / 365).floor();
    final format = DateFormat('منذ $years سنوات');
    return format.format(dateTime);
  }
}

void initiGetprofile(context) {
  var box = Hive.box<ProfileModel>(profileBox);
  if (box.values.isEmpty) {
    ProfileCubit.get(context).getProfile();
  }
}
