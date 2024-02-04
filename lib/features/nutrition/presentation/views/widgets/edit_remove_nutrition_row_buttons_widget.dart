import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/nutrition/presentation/manager/select_cubit.dart/select_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/new_nutrition_dialog_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../manager/nutrition_cubit/nutrition_cubit.dart';

class EditRemoveNutritionRowButtonsWidget extends StatelessWidget {
  const EditRemoveNutritionRowButtonsWidget({super.key, required this.model});
  final NutritionModel model;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');

    return Column(
      children: [
        if (userType == 'admin') RemoveEditNutritionWidget(model: model),
        if (userType == 'writer' && model.writerUid == uid)
          RemoveEditNutritionWidget(model: model)
      ],
    );
  }
}

class RemoveEditNutritionWidget extends StatelessWidget {
  const RemoveEditNutritionWidget({
    super.key,
    required this.model,
  });

  final NutritionModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Row(
        children: [
          Expanded(
            child: customButton(
              onPressed: () {
                if (model.title == '') {
                  showSnackBar(context, S.of(context).no_meals);
                } else {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => NewNutritionDialogWidget(
                      model: model,
                      categoryId: model.categryId ?? '',
                    ),
                  );
                }
              },
              lable: S.of(context).edit,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: customButton(
              color: Colors.red,
              onPressed: () {
                if (model.title != '') {
                  AwesomeDialog(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    showCloseIcon: true,
                    titleTextStyle: TextStyles.style17.copyWith(
                      fontWeight: FontWeight.bold,
                      color: appColor,
                    ),
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.bottomSlide,
                    title: model.title,
                    desc: S.of(context).remove_nutirtion,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      NutritionCubit.get(context).removeNutrition(
                        categoryId: model.categryId ?? '',
                        id: model.id ?? '',
                        context: context,
                      );

                      SelectCubit.get(context).reset();
                    },
                  ).show();
                } else {
                  showSnackBar(context, S.of(context).no_meals);
                }
              },
              lable: S.of(context).remove_question,
            ),
          )
        ],
      ),
    );
  }
}
