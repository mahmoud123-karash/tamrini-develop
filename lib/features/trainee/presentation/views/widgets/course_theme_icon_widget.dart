import 'package:flutter/material.dart';

import 'theme_course_dialog_widget.dart';

class CourseThemeIconWidget extends StatelessWidget {
  const CourseThemeIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const ThemeCourseDialogWidget(),
        );
      },
      icon: const Icon(Icons.light_mode),
    );
  }
}
