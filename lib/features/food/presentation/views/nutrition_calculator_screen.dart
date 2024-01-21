import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/nutrition_remote_data_source.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/supplement_remote_data_source.dart';
import 'package:tamrini/features/food/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/food/data/repo/food_repo_impl.dart';

import '../manager/nutrition_cubit/nutrition_cubit.dart';
import 'widgets/nutrition_calculator_content_builder_widget.dart';

class NutritionCalculatorScreen extends StatelessWidget {
  const NutritionCalculatorScreen(
      {super.key,
      required this.model,
      required this.isMyday,
      required this.id});
  final ClassificationModel model;
  final bool isMyday;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NutritionCubit(
        FoodRepoImpl(
          SupplementRemoteDataSourceImpl(),
          NutritionRemoteDataSourceImpl(),
        ),
      )..getData(id: model.id),
      child: Scaffold(
        appBar: myAppBar(
          model.classification,
        ),
        body: NutritionCalculatorContentBuilderWidget(
          model: model,
          isMyday: isMyday,
          id: id,
        ),
      ),
    );
  }
}
