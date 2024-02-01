import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class BanGymCustomButtonWidget extends StatelessWidget {
  const BanGymCustomButtonWidget({
    super.key,
    required this.uid,
    required this.title,
    required this.ownerId,
    required this.isBanned,
  });
  final String uid, title, ownerId;
  final bool isBanned;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: customButton(
        color: Colors.red,
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
            title: title,
            desc: !isBanned
                ? S.of(context).ban_gym_q
                : S.of(context).no_ban_gym_q,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              GymCubit.get(context).banGym(
                id: uid,
                ownerId: ownerId,
                isBannd: !isBanned,
                context: context,
              );
            },
          ).show();
        },
        lable: !isBanned ? S.of(context).ban_gym : S.of(context).no_ban_gym,
      ),
    );
  }
}
