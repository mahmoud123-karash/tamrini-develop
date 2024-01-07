import 'package:flutter/material.dart';

import '../../../data/models/home_exercise/exercise_model.dart';
import 'home_exercise_item_widget.dart';

class HomeExerciseListViewWidget extends StatelessWidget {
  const HomeExerciseListViewWidget(
      {super.key, required this.list, required this.length});
  final List<Data> list;
  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < length) {
          return HomeExerciseItemWidget(model: list[index]);
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: list.length < length ? list.length : length + 1,
    );
  }
}
