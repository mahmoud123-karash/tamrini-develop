import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/presentation/views/course_details_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class CourseItemWidget extends StatelessWidget {
  const CourseItemWidget({super.key, required this.model});
  final CourseModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        navigateTo(context, CourseDetailsScreen(model: model));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
                    model.title,
                    style: TextStyles.style16Bold.copyWith(
                      color: appColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    DateFormat('EEE, M/d/y', 'en')
                        .format(model.createdAt.toDate()),
                    style: TextStyles.style14,
                  )
                ],
              ),
              const Spacer(),
              Text(
                '${model.duration} ${S.of(context).weeks}',
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
