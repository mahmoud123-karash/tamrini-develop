import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/admod_id.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/new_nutrition_dialog_widget.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/nutrition_calculator_content_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/nutrition_cubit/nutrition_cubit.dart';

class NutritionCalculatorScreen extends StatefulWidget {
  const NutritionCalculatorScreen({
    super.key,
    required this.model,
    required this.isMyday,
    required this.id,
  });
  final ClassificationModel model;
  final bool isMyday;
  final String id;

  @override
  State<NutritionCalculatorScreen> createState() =>
      _NutritionCalculatorScreenState();
}

class _NutritionCalculatorScreenState extends State<NutritionCalculatorScreen> {
  late String userType;
  @override
  void initState() {
    userType = CacheHelper.getData(key: 'usertype');
    NutritionCubit.get(context).getData(id: widget.model.id);
    super.initState();
  }

  RewardedAd? rewardedAd;

  void createRewardAd() {
    RewardedAd.load(
      adUnitId: AdModService.adRewardId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          setState(() {});
        },
        onAdFailedToLoad: (error) {
          rewardedAd = null;
          log('Error:$error');
          setState(() {});
        },
      ),
    );
  }

  void showRewardedAd() {
    if (rewardedAd != null &&
        userType != UserType.admin &&
        userType != UserType.trainer) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          log('success show ad');
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createRewardAd();
        },
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createRewardAd();
        },
      );
      rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {},
      );
      rewardedAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        showRewardedAd();
      },
      child: Scaffold(
        appBar: myAppBar(
          widget.model.classification,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1500)).then(
              (value) {
                NutritionCubit.get(context).getData(
                  id: widget.model.id,
                  isUpate: true,
                );
              },
            );
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              if (userType == UserType.admin || userType == UserType.writer)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: addCustomButton(
                    fontSize: 18,
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => NewNutritionDialogWidget(
                          categoryId: widget.model.id,
                        ),
                      );
                    },
                    lable: S.of(context).add,
                  ),
                ),
              NutritionCalculatorContentBuilderWidget(
                model: widget.model,
                isMyday: widget.isMyday,
                id: widget.id,
                createAd: createRewardAd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
