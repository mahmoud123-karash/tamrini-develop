import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_cubit.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_content_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class DietFoodScreen extends StatefulWidget {
  const DietFoodScreen({super.key});

  @override
  State<DietFoodScreen> createState() => _DietFoodScreenState();
}

class _DietFoodScreenState extends State<DietFoodScreen> {
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
      appBar: myAppBar(S.of(context).diet_food),
      bottomNavigationBar: bannerAd != null
          ? SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(ad: bannerAd!),
            )
          : const SizedBox(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              DietFoodCubit.get(context).getData();
            },
          );
        },
        child: const DietFoodContentBuilderWidget(),
      ),
    );
  }
}
