import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/data/repo/nutrition_repo_impl.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/nutrition_calculator_content_builder_widget.dart';

import '../manager/nutrition_cubit/nutrition_cubit.dart';

class NutritionCalculatorScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NutritionCubit(
        getIt.get<NutritionRepoImpl>(),
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
