import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/cubit/admob_cubit/admob_cubit.dart';
import 'package:tamrini/core/cubit/admob_cubit/admob_states.dart';
import 'package:tamrini/core/utils/user_type.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  @override
  void initState() {
    if (mounted) {
      AdMobCubit.get(context).createBannerAd();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? "";
    return BlocBuilder<AdMobCubit, AdMobStates>(
      builder: (context, state) {
        if (state is SucessLoadBannerAdState) {
          if (userType != UserType.admin && userType != UserType.trainer) {
            return SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(
                ad: state.ad,
                key: UniqueKey(),
              ),
            );
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
