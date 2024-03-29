import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/new_classification_dialog_widget.dart';

import '../nutrition_calculator_screen.dart';

class NutritionClassificationItemWidget extends StatelessWidget {
  const NutritionClassificationItemWidget(
      {super.key,
      required this.model,
      required this.isMyday,
      required this.id});
  final ClassificationModel model;
  final bool isMyday;
  final String id;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: appColor,
            width: 0.3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            leading: userType == UserType.admin
                ? IconButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) =>
                            NewClassificationDialogWidget(model: model),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  )
                : const SizedBox(
                    width: 2,
                    height: 2,
                  ),
            onTap: () {
              navigateTo(
                context,
                NutritionCalculatorScreen(
                  model: model,
                  isMyday: isMyday,
                  id: id,
                ),
              );
            },
            title: Text(
              model.classification,
              style: TextStyles.style17.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
        ),
      ),
    );
  }
}
