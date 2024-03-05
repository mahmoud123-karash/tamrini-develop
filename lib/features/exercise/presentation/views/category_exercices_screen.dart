import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/all_container_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/new_section_screen.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/category_grid_view_widget.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'all_exercises_category_screen.dart';

class CategoryExercisesScreen extends StatefulWidget {
  const CategoryExercisesScreen({
    Key? key,
    this.isCourse = false,
    this.oldModel,
  }) : super(key: key);
  final bool isCourse;
  final DataModel? oldModel;

  @override
  State<CategoryExercisesScreen> createState() =>
      _CategoryExercisesScreenState();
}

class _CategoryExercisesScreenState extends State<CategoryExercisesScreen> {
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
    CourseCubit.get(context).list.clear();
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Scaffold(
      appBar: myAppBar(S.of(context).categoryEx),
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
            if (state is SucessGetExerciseState) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (userType == UserType.admin)
                        addCustomButton(
                          onPressed: () {
                            navigateTo(context, const NewSectionScreen());
                          },
                          lable: S.of(context).add_new_section,
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      AllContainerWidget(
                        image: Assets.imagesAllExer,
                        lable: S.of(context).allEx,
                        onPressed: () {
                          List<DataModel> exercises = [];
                          for (var element in state.exercises) {
                            exercises.addAll(element.data!);
                          }
                          if (exercises.isNotEmpty) {
                            navigateTo(
                              context,
                              AllExercisesCategoryScreen(
                                list: exercises,
                                title: S.of(context).allEx,
                                isAll: true,
                                isCourse: widget.isCourse,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CategoryGridViewWidget(
                        models: state.exercises,
                        isCourse: widget.isCourse,
                        oldData: widget.oldModel,
                      ),
                    ],
                  ),
                ),
              );
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
