import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_card_widget.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';

class ExerciseListViewWidget extends StatelessWidget {
  const ExerciseListViewWidget(
      {super.key,
      required this.list,
      required this.length,
      required this.scrollController});
  final List<DataModel> list;
  final int length;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
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
      itemCount: list.length <= length ? list.length : length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 5,
        );
      },
    );
  }
}
