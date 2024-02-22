import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/cubit/admob_cubit/admob_states.dart';
import 'package:tamrini/core/utils/admod_id.dart';

class AdMobCubit extends Cubit<AdMobStates> {
  AdMobCubit() : super(InitialAdMobState());
  static AdMobCubit get(context) => BlocProvider.of(context);

  String userType = CacheHelper.getData(key: 'usertype');

  void createBannerAd() {
    final bannerAd = BannerAd(
      adUnitId: AdModService.adBannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          emit(SucessLoadBannerAdState(ad as BannerAd));
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          log('$error');
          emit(ErrorLoadBannerAdState(error.toString()));
        },
      ),
    );
    bannerAd.load();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdModService.adInterstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (userType != 'admin' && userType != 'trainer') {
            ad.show();
          }
          emit(SucessLoadInterstitialAdState(ad));
        },
        onAdFailedToLoad: (error) {
          log('$error');
          emit(ErrorLoadInterstitialAdState(error.toString()));
        },
      ),
    );
  }

  void createRewardAd() {
    RewardedAd.load(
      adUnitId: AdModService.adRewardId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
          if (userType != 'admin') {
            ad.show(
              onUserEarnedReward: (ad, reward) {
                log('rewarded');
              },
            );
          }
          emit(SucessLoadRewardAdState(ad));
        },
        onAdFailedToLoad: (error) {
          log('$error');
          emit(ErrorLoadRewardAdState(error.toString()));
        },
      ),
    );
  }
}
