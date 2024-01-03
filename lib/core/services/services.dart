import 'package:fuzzy/fuzzy.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:url_launcher/url_launcher.dart';

void openUri({required Uri uri}) async {
  await launchUrl(
    uri,
  );
}

void getUserType(UserModel model) {
  if (model.isSubscribedToTrainer) {
    saveUserType('Trainer');
  } else if (model.isSubscribedToStoreOwner) {
    saveUserType('StoreOwner');
  } else if (model.isSubscribedToPublisher) {
    saveUserType('Publisher');
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
