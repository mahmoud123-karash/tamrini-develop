import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveSupplementCustomButtonWidget extends StatelessWidget {
  const RemoveSupplementCustomButtonWidget({
    super.key,
    required this.model,
    required this.categoryId,
  });
  final SupplementData model;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {
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
            desc: S.of(context).supplement_remove_question,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              SupplementCubit.get(context).removeSupplement(
                id: categoryId,
                oldModel: model,
                message: S.of(context).success_remove,
              );
            },
          ).show();
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
