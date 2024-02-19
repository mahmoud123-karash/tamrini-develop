import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/cubit/admob_cubit/admob_cubit.dart';
import 'package:tamrini/core/cubit/admob_cubit/admob_states.dart';

class LargeBannerAdWidget extends StatefulWidget {
  const LargeBannerAdWidget({super.key});

  @override
  State<LargeBannerAdWidget> createState() => _LargeBannerAdWidgetState();
}

class _LargeBannerAdWidgetState extends State<LargeBannerAdWidget> {
  @override
  void initState() {
    if (mounted) {
      AdMobCubit.get(context).createBannerAd();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return BlocBuilder<AdMobCubit, AdMobStates>(
      builder: (context, state) {
        if (state is SucessLoadBannerAdState) {
          if (userType != 'admin') {
            return SizedBox(
              width: AdSize.largeBanner.width.toDouble(),
              height: AdSize.largeBanner.height.toDouble(),
              child: AdWidget(ad: state.ad),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
