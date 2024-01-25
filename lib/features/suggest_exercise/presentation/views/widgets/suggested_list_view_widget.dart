import 'package:flutter/widgets.dart';
import 'package:tamrini/features/suggest_exercise/data/models/suggest_model/suggest_model.dart';

import 'suggested_exercise_card_widget.dart';

class SuggestedListViewWidget extends StatelessWidget {
  const SuggestedListViewWidget({super.key, required this.list});
  final List<SuggestModel> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: ListView.builder(
        itemBuilder: (context, index) => SuggestedExerciseCardWidget(
          exercise: list[index],
        ),
        itemCount: list.length,
      ),
    );
  }
}
