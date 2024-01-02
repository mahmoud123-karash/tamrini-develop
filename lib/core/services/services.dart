import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
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
