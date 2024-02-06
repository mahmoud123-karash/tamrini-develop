import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class RowValueLableWidget extends StatelessWidget {
  const RowValueLableWidget(
      {super.key, required this.lable, required this.value});
  final String lable, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$lable:',
          style: TextStyles.style17.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
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
