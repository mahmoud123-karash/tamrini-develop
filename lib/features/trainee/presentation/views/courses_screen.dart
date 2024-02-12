import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/views/new_course_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/course_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class CourcesScreen extends StatelessWidget {
  const CourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).courses),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: addCustomButton(
              onPressed: () {
                navigateTo(context, const NewCourseScreen());
              },
              lable: S.of(context).add_new_course,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: ListView.separated(
                itemBuilder: (context, index) => const CourseItemWidget(),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
