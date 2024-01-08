import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class TrainerInfoWidget extends StatelessWidget {
  const TrainerInfoWidget(
      {super.key, required this.icon, required this.value, required this.text});
  final IconData icon;
  final String value, text;

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
          "+ ${value.toString()}",
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
