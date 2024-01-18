import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/food/presentation/manager/nutrition_cubit/nutrition_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/nutrition_cubit/nutrition_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/message_builder_widget.dart';
import 'package:tamrini/features/food/presentation/views/widgets/nutrition_calculator_content.dart';
import 'package:tamrini/generated/l10n.dart';

class NutritionCalculatorContentBuilderWidget extends StatelessWidget {
  const NutritionCalculatorContentBuilderWidget({
    super.key,
    required this.model,
  });
  final ClassificationModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionCubit, NutritionStates>(
      builder: (context, state) {
        if (state is SucessGetNutritionState) {
          if (state.list.isEmpty) {
            return MessageBuilderWidget(message: S.of(context).no_results);
          }
          return NutritionCalCulatorContentWidget(
            model: model,
            list: state.list,
          );
        } else if (state is ErrorGetNutritionState) {
          return MessageBuilderWidget(message: state.message);
        } else {
          return loadingWidget();
        }
      },
    );
  }
}
