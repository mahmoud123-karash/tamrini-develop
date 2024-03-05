import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';

import 'category_item_widget.dart';

class CategoryGridViewWidget extends StatelessWidget {
  const CategoryGridViewWidget(
      {super.key,
      required this.models,
      required this.isCourse,
      required this.oldData});
  final List<ExerciseModel> models;
  final bool isCourse;
  final DataModel? oldData;

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
            isCourse: isCourse,
            oldData: oldData,
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
