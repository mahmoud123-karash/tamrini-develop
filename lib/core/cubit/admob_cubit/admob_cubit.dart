import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/cubit/admob_cubit/admob_states.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/core/utils/user_type.dart';

class AdMobCubit extends Cubit<AdMobStates> {
  AdMobCubit() : super(InitialAdMobState());
  static AdMobCubit get(context) => BlocProvider.of(context);

  String userType = CacheHelper.getData(key: 'usertype') ?? "";

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdModService.adInterstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (userType != UserType.admin && userType != UserType.trainer) {
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
}
