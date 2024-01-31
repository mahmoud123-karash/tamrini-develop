import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class DateSubEndColumWidget extends StatelessWidget {
  const DateSubEndColumWidget(
      {super.key,
      required this.label,
      required this.value,
      required this.color});
  final String label, value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyles.style16Bold.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: TextStyles.style14,
        )
      ],
    );
  }
}
