import 'package:flutter/foundation.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
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
