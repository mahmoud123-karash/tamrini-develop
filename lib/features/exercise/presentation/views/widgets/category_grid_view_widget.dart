import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';

import 'category_item_widget.dart';

class CategoryGridViewWidget extends StatelessWidget {
  const CategoryGridViewWidget({super.key, required this.models});
  final List<ExerciseModel> models;

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
          return CategoryItemWidget(
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
