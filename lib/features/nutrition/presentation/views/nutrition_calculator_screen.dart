import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
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
  @override
  void initState() {
    NutritionCubit.get(context).getData(id: widget.model.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');

    return Scaffold(
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
            if (userType == 'admin' || userType == 'writer')
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
                      builder: (context) =>
                          NewNutritionDialogWidget(categoryId: widget.model.id),
                    );
                  },
                  lable: S.of(context).add,
                ),
              ),
            NutritionCalculatorContentBuilderWidget(
              model: widget.model,
              isMyday: widget.isMyday,
              id: widget.id,
            ),
          ],
        ),
      ),
    );
  }
}
