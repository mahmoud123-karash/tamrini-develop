import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.text,
    required this.data,
  });
  final String text;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$text:",
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            data,
            style: TextStyles.style13.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
