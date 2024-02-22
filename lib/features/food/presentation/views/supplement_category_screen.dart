import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/views/new_category_screen.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_grid_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementsCategoryScreen extends StatefulWidget {
  const SupplementsCategoryScreen({Key? key, required this.isCourse})
      : super(key: key);
  final bool isCourse;

  @override
  State<SupplementsCategoryScreen> createState() =>
      _SupplementsCategoryScreenState();
}

class _SupplementsCategoryScreenState extends State<SupplementsCategoryScreen> {
  @override
  void initState() {
    String userType = CacheHelper.getData(key: 'usertype');
    if (userType != 'admin' && userType != 'trainer') {
      createBannerAd();
    }
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
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return Scaffold(
      bottomNavigationBar: bannerAd != null
          ? SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(ad: bannerAd!),
            )
          : const SizedBox(),
      appBar: myAppBar(S.of(context).nuttritions),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              SupplementCubit.get(context).getData();
            },
          );
        },
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            if (userType == 'admin')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: addCustomButton(
                  onPressed: () {
                    navigateTo(context, const NewCategoryScreen());
                  },
                  lable: S.of(context).add_nutrition_classification,
                ),
              ),
            Expanded(
              child: SupplementGridViewBuilderWidget(isCourse: widget.isCourse),
            ),
          ],
        ),
      ),
    );
  }
}
