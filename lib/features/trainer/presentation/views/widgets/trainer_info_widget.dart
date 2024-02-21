import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerInfoWidget extends StatelessWidget {
  const TrainerInfoWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.text,
    this.isPrice = false,
  });
  final IconData icon;
  final String value, text;
  final bool isPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: appColor.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              icon,
              color: appColor,
            ),
          ),
        ),
        Text(
          "${isPrice ? '' : '+'} ${value.toString()} ${isPrice ? S.of(context).dinar : ''}",
          style: TextStyles.style14,
        ),
        Text(
          text,
          style: TextStyles.style16Bold,
        )
      ],
    );
  }
}
