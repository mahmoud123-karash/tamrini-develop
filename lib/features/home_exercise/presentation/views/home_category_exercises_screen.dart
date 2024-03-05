import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/home_category_exercise_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeCategoryExercisesScreen extends StatefulWidget {
  const HomeCategoryExercisesScreen({Key? key}) : super(key: key);

  @override
  State<HomeCategoryExercisesScreen> createState() =>
      _HomeCategoryExercisesScreenState();
}

class _HomeCategoryExercisesScreenState
    extends State<HomeCategoryExercisesScreen> {
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
        S.of(context).home_exercises,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              HomeExerciseCubit.get(context).getData();
            },
          );
        },
        child: const HomeCategoryExerciseBuilderWidget(),
      ),
    );
  }
}
