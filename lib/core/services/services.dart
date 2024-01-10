import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart'
    as user;

import 'package:tamrini/features/trainer/data/models/trainer_model/rating_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share/flutter_share.dart';

void getUserType(UserModel model) {
  if (model.isSubscribedToTrainer) {
    saveUserType('Trainer');
  } else if (model.isSubscribedToStoreOwner) {
    saveUserType('StoreOwner');
  } else if (model.isSubscribedToGymOwner) {
    saveUserType('GymOwner');
  } else if (model.isSubscribedToPublisher) {
    saveUserType('Publisher');
  } else if (model.admin) {
    saveUserType('Admin');
  } else {
    saveUserType('User');
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
