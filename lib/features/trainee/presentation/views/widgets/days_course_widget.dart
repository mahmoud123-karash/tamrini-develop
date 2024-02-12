import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

import 'day_course_item_widget.dart';

class DaysCourseWidget extends StatelessWidget {
  const DaysCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: daysCourse(context).length,
        itemBuilder: (context, index) {
          return DayCourseItemWidget(
            lable: daysCourse(context)[index],
            num: index + 1,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }
}

List<String> daysCourse(context) => [
      S.of(context).sut,
      S.of(context).sun,
      S.of(context).mon,
      S.of(context).tue,
      S.of(context).wed,
      S.of(context).thurs,
      S.of(context).fri,
    ];
