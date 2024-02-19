import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdMobStates {}

class InitialAdMobState extends AdMobStates {}

class SucessLoadBannerAdState extends AdMobStates {
  final BannerAd ad;
  SucessLoadBannerAdState(this.ad);
}

class ErrorLoadBannerAdState extends AdMobStates {
  final String message;
  ErrorLoadBannerAdState(this.message);
}

class SucessLoadInterstitialAdState extends AdMobStates {
  final InterstitialAd interstitialAd;
  SucessLoadInterstitialAdState(this.interstitialAd);
}

class ErrorLoadInterstitialAdState extends AdMobStates {
  final String message;
  ErrorLoadInterstitialAdState(this.message);
}

class SucessLoadRewardAdState extends AdMobStates {
  final RewardedAd rewardedAd;
  SucessLoadRewardAdState(this.rewardedAd);
}

class ErrorLoadRewardAdState extends AdMobStates {
  final String message;
  ErrorLoadRewardAdState(this.message);
}
