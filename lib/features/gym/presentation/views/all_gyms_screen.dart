import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/all_gym_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/gym_cubit/gym_cubit.dart';

class AllGymsScreen extends StatefulWidget {
  const AllGymsScreen({super.key});

  @override
  State<AllGymsScreen> createState() => _AllGymsScreenState();
}

class _AllGymsScreenState extends State<AllGymsScreen> {
  @override
  void initState() {
    createBannerAd();
    super.initState();
  }

  BannerAd? bannerAd;
  void createBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AdModService.adBannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    bannerAd!.load();
  }

  @override
  void dispose() {
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bannerAd != null
          ? SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(ad: bannerAd!),
            )
          : const SizedBox(),
      appBar: myAppBar(S.of(context).slatGym),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              GymCubit.get(context).getData(update: false);
            },
          );
        },
        child: BlocBuilder<GymCubit, GymStates>(
          builder: (context, state) {
            if (state is SucessGetGymsState) {
              return AllGymsContentWidget(models: state.list);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
