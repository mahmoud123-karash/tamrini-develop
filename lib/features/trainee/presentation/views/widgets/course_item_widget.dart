import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class CourseItemWidget extends StatelessWidget {
  const CourseItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: greyColor.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'course name',
                    style: TextStyles.style16Bold.copyWith(
                      color: appColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '10/12/2024',
                    style: TextStyles.style14,
                  )
                ],
              ),
              const Spacer(),
              Text(
                '4 weeks',
                style: TextStyles.style14.copyWith(
                  color: appColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
