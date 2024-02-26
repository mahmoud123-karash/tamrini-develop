import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class ProfitsRowInfoWidget extends StatelessWidget {
  const ProfitsRowInfoWidget({
    super.key,
    required this.lable,
    required this.value,
  });
  final String lable, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          lable,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          '$value  ${S.of(context).dinar}',
          style: TextStyles.style15.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        ),
      ],
    );
  }
}
