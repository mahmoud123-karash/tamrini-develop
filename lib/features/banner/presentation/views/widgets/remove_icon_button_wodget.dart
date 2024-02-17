import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveiconButtonWidget extends StatelessWidget {
  const RemoveiconButtonWidget({super.key, required this.model});
  final BannerModel model;

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
          title: S.of(context).remove_banner,
          desc: S.of(context).remove_banner_question,
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
