import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveiconGymWidget extends StatelessWidget {
  const RemoveiconGymWidget({super.key, required this.model});
  final GymModel model;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: Intl.getCurrentLocale() == 'ar' ? 0 : null,
      right: Intl.getCurrentLocale() == 'en' ? 0 : null,
      child: GestureDetector(
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
            title: model.name,
            desc: S.of(context).gym_remove_question,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              GymCubit.get(context).removeGym(
                id: model.id,
                message: S.of(context).success_remove,
                assets: model.assets,
              );
            },
          ).show();
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
