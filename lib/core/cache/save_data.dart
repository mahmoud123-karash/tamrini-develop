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

void saveImagePath(value) => CacheHelper.saveData(
      key: 'imagepath',
      value: value,
    );

void saveAddress(value) => CacheHelper.saveData(
      key: 'address',
      value: value,
    );
