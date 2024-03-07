import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/all_exercises_category_content_widget.dart';

class AllExercisesCategoryScreen extends StatefulWidget {
  const AllExercisesCategoryScreen({
    super.key,
    required this.title,
    this.list,
    this.isAll = false,
    required this.isCourse,
  });
  final String title;
  final List<DataModel>? list;
  final bool isAll;
  final bool isCourse;

  @override
  State<AllExercisesCategoryScreen> createState() =>
      _AllExercisesCategoryScreenState();
}

class _AllExercisesCategoryScreenState
    extends State<AllExercisesCategoryScreen> {
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
      appBar: myAppBar(widget.title),
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
              ExerciseCubit.get(context).getData();
            },
          );
        },
        child: BlocBuilder<ExerciseCubit, ExerciseStates>(
          builder: (context, state) {
            var cubit = ExerciseCubit.get(context);
            String id = CacheHelper.getData(key: 'exerciseId') ?? '';
            return AllExercisesCategoryContentWidget(
              list: widget.isAll
                  ? widget.list!
                  : cubit.getExercise(id: id).data ?? [],
              isAll: widget.isAll,
              isCourse: widget.isCourse,
            );
          },
        ),
      ),
    );
  }
}
