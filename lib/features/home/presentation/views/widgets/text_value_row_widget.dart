import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class TextValueRowWidget extends StatelessWidget {
  const TextValueRowWidget(
      {super.key, required this.text, required this.value});
  final String text, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          " $text: ",
          style: TextStyles.style20.copyWith(
            color: appColor,
          ),
        ),
        Text(
          value,
          style: TextStyles.style20.copyWith(),
        ),
      ],
    );
  }
}
