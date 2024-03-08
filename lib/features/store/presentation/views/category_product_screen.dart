import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/all_container_widget.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/views/products_category_screen.dart';
import 'package:tamrini/features/store/presentation/views/widgets/category_grid_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({
    super.key,
    required this.list,
  });
  final List<ProductModel> list;

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
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
    return Scaffold(
      bottomNavigationBar: bannerAd != null
          ? SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(ad: bannerAd!),
            )
          : const SizedBox(),
      appBar: myAppBar(
        S.of(context).category,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AllContainerWidget(
                onPressed: () {
                  StoreCubit.get(context).displayedList = widget.list;
                  navigateTo(context,
                      ProductsCategoryScreen(title: S.of(context).allProducts));
                },
                image: Assets.imagesAllProduct,
                lable: S.of(context).allProducts,
              ),
              const SizedBox(
                height: 10,
              ),
              CategoryGridViewBuilderWidget(
                products: widget.list,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
