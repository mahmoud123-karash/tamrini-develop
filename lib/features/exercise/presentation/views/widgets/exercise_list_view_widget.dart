import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_card_widget.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';

class ExerciseListViewWidget extends StatelessWidget {
  const ExerciseListViewWidget(
      {super.key,
      required this.list,
      required this.length,
      required this.scrollController,
      required this.isAll,
      required this.isCourse});
  final List<DataModel> list;
  final int length;
  final ScrollController scrollController;
  final bool isAll;
  final bool isCourse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < length) {
            return ExerciseCardWidget(
              exercise: list[index],
              isAll: isAll,
              id: list[index].id ?? '',
              isCourse: isCourse,
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
      ),
    );
  }
}
