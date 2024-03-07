import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdMobStates {}

class InitialAdMobState extends AdMobStates {}

class SucessLoadInterstitialAdState extends AdMobStates {
  final InterstitialAd interstitialAd;
  SucessLoadInterstitialAdState(this.interstitialAd);
}

class ErrorLoadInterstitialAdState extends AdMobStates {
  final String message;
  ErrorLoadInterstitialAdState(this.message);
}
