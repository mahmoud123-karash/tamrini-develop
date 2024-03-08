import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_cover_image_widget.dart';

import 'widgets/store_category_colum_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key, required this.model});
  final StoreModel model;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    String userType = CacheHelper.getData(key: 'usertype') ?? "";
    if (userType != UserType.admin && userType != UserType.trainer) {
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
  void dispose() {
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets systemPadding = MediaQuery.of(context).padding;
    return Scaffold(
      bottomNavigationBar: bannerAd != null
          ? SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(ad: bannerAd!),
            )
          : const SizedBox(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: systemPadding.top + systemPadding.bottom,
            ),
            StoreCoverImageWidget(
              isBanned: widget.model.isBanned,
              name: widget.model.name,
              contact: widget.model.contact,
              uid: widget.model.storeOwnerUid,
              image: widget.model.image,
              num: widget.model.products!.length,
            ),
            StoreCategoryColumWidget(
              list: widget.model.products ?? [],
            )
          ],
        ),
      ),
    );
  }
}
