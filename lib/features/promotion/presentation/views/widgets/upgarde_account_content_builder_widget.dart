import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';
import 'package:tamrini/features/promotion/presentation/manager/promotion_cubit/promotion_cubit.dart';
import 'package:tamrini/features/promotion/presentation/manager/promotion_cubit/promotion_states.dart';
import 'package:tamrini/features/promotion/presentation/views/widgets/promotion_review_widget.dart';
import 'package:tamrini/features/promotion/presentation/views/widgets/upgrade_account_content_widget.dart';

class UpgradeAccountContentBuilderWidget extends StatelessWidget {
  const UpgradeAccountContentBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionCubit, PromotionStates>(
      builder: (context, state) {
        if (state is SuccessGetPromotionsState) {
          String uid = CacheHelper.getData(key: 'uid');

          if (state.list.any((element) => element.userId == uid)) {
            PromotionModel model =
                state.list.firstWhere((element) => element.userId == uid);
            return Center(
              child: PromotionReviewWidget(model: model),
            );
          } else {
            return const UpgradeAccountContentWidget();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
