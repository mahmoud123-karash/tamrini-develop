import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/data/models/home_exercise/home_exercise_model.dart';

import 'home_category_item_widget.dart';

class HomeCategoryGridViewWidget extends StatelessWidget {
  const HomeCategoryGridViewWidget({super.key, required this.models});
  final List<HomeExerciseModel> models;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          models.sort((a, b) => a.order!.compareTo(b.order!));
          return HomeCategoryItemWidget(
            model: models[index],
          );
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }
}
