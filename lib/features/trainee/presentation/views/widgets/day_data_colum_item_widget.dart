import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class DayDataColumItemWidget extends StatelessWidget {
  const DayDataColumItemWidget({
    super.key,
    required this.day,
    required this.data,
  });
  final String day, data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$day:',
          style: TextStyles.style16Bold.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          color: greyColor.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data,
              style: TextStyles.style13.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
