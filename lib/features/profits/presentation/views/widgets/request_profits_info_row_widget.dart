import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class RequestProfitsInfoRowWidget extends StatelessWidget {
  const RequestProfitsInfoRowWidget(
      {super.key, required this.lable, required this.value});
  final String lable, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$lable:',
          style: TextStyles.style13.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: TextStyles.style13.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
