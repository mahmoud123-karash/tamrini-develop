import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_states.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/all_home_exercise_category_content_widget.dart';

class AllHomeExerciseCategoryScreen extends StatefulWidget {
  const AllHomeExerciseCategoryScreen({
    super.key,
    required this.title,
    required this.id,
    required this.isAll,
    this.list,
  });
  final String title;
  final String id;
  final bool isAll;
  final List<Data>? list;

  @override
  State<AllHomeExerciseCategoryScreen> createState() =>
      _AllHomeExerciseCategoryScreenState();
}

class _AllHomeExerciseCategoryScreenState
    extends State<AllHomeExerciseCategoryScreen> {
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
              HomeExerciseCubit.get(context).getData();
            },
          );
        },
        child: BlocBuilder<HomeExerciseCubit, HomeExerciseStates>(
          builder: (context, state) {
            HomeExerciseModel? model = widget.id != ''
                ? HomeExerciseCubit.get(context).getSection(widget.id)
                : null;
            return AllHomeExercisesCategoryContentWidget(
              models:
                  widget.list != null ? widget.list ?? [] : model!.data ?? [],
              id: widget.id,
              isAll: widget.isAll,
            );
          },
        ),
      ),
    );
  }
}
