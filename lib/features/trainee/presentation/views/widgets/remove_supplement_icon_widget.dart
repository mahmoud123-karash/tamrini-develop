import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveSupplementIconWidget extends StatelessWidget {
  const RemoveSupplementIconWidget(
      {super.key,
      required this.model,
      required this.supplementId,
      required this.name});
  final TraineeModel model;
  final String supplementId, name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
            title: name,
            desc: S.of(context).remove_supplement_question,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              TraineeCubit.get(context).removeSupplements(
                model: model,
                supplementId: supplementId,
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
