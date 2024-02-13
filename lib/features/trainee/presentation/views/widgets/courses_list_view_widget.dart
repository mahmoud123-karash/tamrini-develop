import 'package:flutter/material.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/course_item_widget.dart';

class CoursesListViewWidget extends StatelessWidget {
  const CoursesListViewWidget({super.key, required this.list});
  final List<CourseModel> list;

  @override
  Widget build(BuildContext context) {
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => CourseItemWidget(model: list[index]),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: list.length,
      ),
    );
  }
}
