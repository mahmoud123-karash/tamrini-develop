import 'dart:io';

class AdModService {
  static String adBannerId = Platform.isAndroid
      ? 'ca-app-pub-7552807490163247/4705534711'
      : 'ca-app-pub-7552807490163247/8706512994';

  static String adInterstitialId = Platform.isAndroid
      ? 'ca-app-pub-7552807490163247/3303988987'
      : 'ca-app-pub-7552807490163247/3370425834';

  static String adRewardId = Platform.isAndroid
      ? 'ca-app-pub-7552807490163247/7968146399'
      : 'ca-app-pub-7552807490163247/8431180820';
}
