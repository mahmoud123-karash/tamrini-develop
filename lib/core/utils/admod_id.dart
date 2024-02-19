import 'dart:io';

class AdModService {
  static String adBannerId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-7552807490163247/8706512994';

  static String adInterstitialId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-7552807490163247/3370425834';

  static String adRewardId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-7552807490163247/8431180820';
}
