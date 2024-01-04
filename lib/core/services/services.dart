import 'package:flutter/foundation.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/store_model/rating_model.dart';
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

List<DataModel> searchExercise(value, List<DataModel> data) {
  final options = [for (var element in data) element.title!];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
}

List<ArticleModel> searchArticles(value, List<ArticleModel> data) {
  final options = [for (var element in data) element.title!];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
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
