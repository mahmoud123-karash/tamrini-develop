import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class ProfitsColumProfitsWidget extends StatelessWidget {
  const ProfitsColumProfitsWidget({super.key, required this.profits});
  final num profits;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).profits,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          '${profits.toString()}  ${S.of(context).dinar}',
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        ),
      ],
    );
  }
}
