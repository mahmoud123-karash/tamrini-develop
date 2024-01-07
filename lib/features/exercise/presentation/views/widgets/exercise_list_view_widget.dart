import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_card_widget.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';

class ExerciseListViewWidget extends StatelessWidget {
  const ExerciseListViewWidget(
      {super.key, required this.list, required this.length});
  final List<DataModel> list;
  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < length) {
          return ExerciseCardWidget(
            exercise: list[index],
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      itemCount: list.length < length ? list.length : length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 5,
        );
      },
    );
  }
}
