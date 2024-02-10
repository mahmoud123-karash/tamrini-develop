import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class PromotionDialogWidget extends StatelessWidget {
  const PromotionDialogWidget({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).congratulation,
        style: TextStyles.style16Bold.copyWith(
          color: Colors.amber,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).accept_request_promotion,
            style: TextStyles.style14.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            type,
            style: TextStyles.style14.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(S.of(context).logout_and_login_again),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            logOut(context);
          },
          child: Text(S.of(context).log_out),
        ),
      ],
    );
  }
}
