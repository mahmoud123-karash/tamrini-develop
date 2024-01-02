import 'package:tamrini/core/cache/shared_preference.dart';

void saveUid(value) => CacheHelper.saveData(
      key: 'uid',
      value: value,
    );

void saveUserType(value) => CacheHelper.saveData(
      key: 'usertype',
      value: value,
    );

void saveGender(value) => CacheHelper.saveData(
      key: 'gender',
      value: value,
    );

void savePrivacy(value) => CacheHelper.saveData(
      key: 'privacy',
      value: value,
    );

void saveDeviceToken(value) => CacheHelper.saveData(
      key: 'deviceToken',
      value: value,
    );
