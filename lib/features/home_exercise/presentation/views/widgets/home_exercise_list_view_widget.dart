import 'package:flutter/material.dart';

import '../../../data/models/home_exercise/exercise_data.dart';
import 'home_exercise_item_widget.dart';

class HomeExerciseListViewWidget extends StatelessWidget {
  const HomeExerciseListViewWidget({
    super.key,
    required this.list,
    required this.length,
    required this.scrollController,
    required this.isAll,
  });
  final List<Data> list;
  final int length;
  final bool isAll;

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < length) {
          return HomeExerciseItemWidget(model: list[index], isAll: isAll);
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: list.length <= length ? list.length : length + 1,
    );
  }
}
