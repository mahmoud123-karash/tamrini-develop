import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_category_articles_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementArticlesScreen extends StatefulWidget {
  const SupplementArticlesScreen({
    super.key,
    required this.title,
    required this.id,
    required this.isCourse,
  });
  final String title;
  final String id;
  final bool isCourse;

  @override
  State<SupplementArticlesScreen> createState() =>
      _SupplementArticlesScreenState();
}

class _SupplementArticlesScreenState extends State<SupplementArticlesScreen> {
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
      appBar: myAppBar(widget.title),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              SupplementCubit.get(context).getData();
            },
          );
        },
        child: BlocBuilder<SupplementCubit, SupplementStates>(
          builder: (context, state) {
            SupplementModel? category =
                SupplementCubit.get(context).getSupplement(widget.id);
            return category == null
                ? Center(
                    child: Text(
                      S.of(context).category_removed,
                    ),
                  )
                : SupplementArticlesContentWidget(
                    category: category,
                    isCourse: widget.isCourse,
                  );
          },
        ),
      ),
    );
  }
}
