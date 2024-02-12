import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class CourseNameRowWidget extends StatelessWidget {
  const CourseNameRowWidget({
    super.key,
    required this.value,
    required this.lable,
    required this.icon,
  });

  final String value, lable;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.amber,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "$lable :",
          style: TextStyles.style14.copyWith(
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
        ),
      ],
    );
  }
}
