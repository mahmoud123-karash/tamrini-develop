import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cubit/admob_cubit/admob_states.dart';
import 'package:tamrini/core/utils/admod_id.dart';

class AdMobCubit extends Cubit<AdMobStates> {
  AdMobCubit() : super(InitialAdMobState());
  static AdMobCubit get(context) => BlocProvider.of(context);

  void createBannerAd() {
    final bannerAd = BannerAd(
      adUnitId: AdModService.adBannerId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          emit(SucessLoadBannerAdState(ad as BannerAd));
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
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
          emit(SucessLoadInterstitialAdState(ad));
        },
        onAdFailedToLoad: (error) {
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
          emit(SucessLoadRewardAdState(ad));
        },
        onAdFailedToLoad: (error) {
          emit(ErrorLoadRewardAdState(error.toString()));
        },
      ),
    );
  }
}
