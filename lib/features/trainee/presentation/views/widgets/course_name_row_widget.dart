import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class CourseNameRowWidget extends StatelessWidget {
  const CourseNameRowWidget({
    super.key,
    required this.value,
    required this.lable,
    required this.icon,
    required this.themeColor,
  });

  final String value, lable;
  final IconData icon;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
            color: themeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
          constraints: BoxConstraints(maxWidth: width / 2),
          child: Text(
            value,
            style: TextStyles.style14.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
