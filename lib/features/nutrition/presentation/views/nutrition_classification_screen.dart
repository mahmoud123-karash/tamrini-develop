import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/nutrition/presentation/manager/classification_cubit/classification_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/new_classification_dialog_widget.dart';

import '../../../../generated/l10n.dart';
import 'widgets/nutrition_classification_list_view_builder_widget.dart';

class NutritionClassificationScreen extends StatefulWidget {
  const NutritionClassificationScreen({
    super.key,
    this.isMyday = false,
    this.id = '',
  });
  final bool isMyday;
  final String id;

  @override
  State<NutritionClassificationScreen> createState() =>
      _NutritionClassificationScreenState();
}

class _NutritionClassificationScreenState
    extends State<NutritionClassificationScreen> {
  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return Scaffold(
      appBar: myAppBar(S.of(context).values_food),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              ClassificationCubit.get(context).getData();
            },
          );
        },
        child: Column(
          children: [
            if (userType == 'admin')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: addCustomButton(
                  fontSize: 16,
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) =>
                          const NewClassificationDialogWidget(),
                    );
                  },
                  lable: S.of(context).add_nutrition_classification,
                ),
              ),
            Expanded(
              child: NutritionClassificationListViewBuilderWidget(
                isMyday: widget.isMyday,
                id: widget.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
