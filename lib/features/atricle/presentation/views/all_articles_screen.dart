import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/all_articles_content_builder_widget.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({super.key});

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
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
      appBar: myAppBar(S.of(context).articlesT),
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
              ArticlesCubit.get(context).getData();
            },
          );
        },
        child: const AllArticlesContentBuilderWidget(),
      ),
    );
  }
}
