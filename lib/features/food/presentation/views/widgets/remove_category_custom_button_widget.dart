import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveCategoryCustomButtonWidget extends StatelessWidget {
  const RemoveCategoryCustomButtonWidget({super.key, required this.model});
  final SupplementModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
          desc: S.of(context).remove_category_question,
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            SupplementCubit.get(context).removeCategory(
              oldModel: model,
              context: context,
            );
          },
        ).show();
      },
      child: const Icon(
        Icons.delete_forever,
        color: Colors.red,
      ),
    );
  }
}
