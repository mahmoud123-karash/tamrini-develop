import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/new_section_screen.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/all_exercises_container_widget.dart';
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
  }) : super(key: key);
  final bool isCourse;

  @override
  State<CategoryExercisesScreen> createState() =>
      _CategoryExercisesScreenState();
}

class _CategoryExercisesScreenState extends State<CategoryExercisesScreen> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7552807490163247~3569054859'
      : 'ca-app-pub-3940256099942544/2934735716';

  /// Loads a banner ad.
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          log('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CourseCubit.get(context).list.clear();
    String userType = CacheHelper.getData(key: 'usertype');

    return Scaffold(
      appBar: myAppBar(S.of(context).categoryEx),
      body: BlocBuilder<ExerciseCubit, ExerciseStates>(
        builder: (context, state) {
          if (state is SucessGetExerciseState) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (_bannerAd != null)
                      SizedBox(
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    if (userType == 'admin')
                      addCustomButton(
                        onPressed: () {
                          navigateTo(context, const NewSectionScreen());
                        },
                        lable: S.of(context).add_new_section,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    AllExercisesContainerWidget(
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
                        models: state.exercises, isCourse: widget.isCourse),
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
    );
  }
}
