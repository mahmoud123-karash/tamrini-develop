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

void saveSwiperIndex(value) => CacheHelper.saveData(
      key: 'index',
      value: value,
    );

void saveTheme(value) => CacheHelper.saveData(
      key: 'isdark',
      value: value,
    );

void saveLanguage(value) => CacheHelper.saveData(
      key: 'lang',
      value: value,
    );

void saveLat(value) => CacheHelper.saveData(
      key: 'lat',
      value: value,
    );

void saveLong(value) => CacheHelper.saveData(
      key: 'long',
      value: value,
    );

void saveUnReadList(value) => CacheHelper.saveData(
      key: 'length',
      value: value,
    );

void saveNotificationList(value) => CacheHelper.saveData(
      key: 'lengthN',
      value: value,
    );

void saveMessagesList(value) => CacheHelper.saveData(
      key: 'lengthM',
      value: value,
    );

void saveSystemList(value) => CacheHelper.saveData(
      key: 'lengthS',
      value: value,
    );
