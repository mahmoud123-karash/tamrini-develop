import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';

import 'home_category_item_widget.dart';

class HomeCategoryGridViewWidget extends StatelessWidget {
  const HomeCategoryGridViewWidget(
      {super.key, required this.models, this.oldData,  this.id});
  final List<HomeExerciseModel> models;
  final Data? oldData;
  final String? id;

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
            id: id,
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
