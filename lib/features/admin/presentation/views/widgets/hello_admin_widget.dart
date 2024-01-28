import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class HelloAdminWidget extends StatelessWidget {
  const HelloAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).hello,
          style: TextStyles.style16Bold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          S.of(context).admin,
          style: TextStyles.style16Bold.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Ionicons.hand_right,
          color: Colors.amber,
        )
      ],
    );
  }
}
