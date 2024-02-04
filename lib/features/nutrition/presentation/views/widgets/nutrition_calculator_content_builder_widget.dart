import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/presentation/manager/nutrition_cubit/nutrition_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/manager/nutrition_cubit/nutrition_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/message_builder_widget.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/nutrition_calculator_content.dart';

class NutritionCalculatorContentBuilderWidget extends StatelessWidget {
  const NutritionCalculatorContentBuilderWidget({
    super.key,
    required this.model,
    required this.isMyday,
    required this.id,
  });
  final ClassificationModel model;
  final bool isMyday;
  final String id;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<NutritionCubit, NutritionStates>(
      builder: (context, state) {
        if (state is SucessGetNutritionState) {
          return NutritionCalCulatorContentWidget(
            model: model,
            list: state.list,
            isMyday: isMyday,
            id: id,
          );
        } else if (state is ErrorGetNutritionState) {
          return MessageBuilderWidget(message: state.message);
        } else {
          return Padding(
            padding: EdgeInsets.only(top: height / 3),
            child: loadingWidget(),
          );
        }
      },
    );
  }
}
