import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class LableValueRowWidget extends StatelessWidget {
  const LableValueRowWidget(
      {super.key, required this.lable, required this.value});
  final String lable, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(lable),
        const Spacer(),
        Text(
          value,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
