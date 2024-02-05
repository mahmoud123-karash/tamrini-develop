import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class NoExerciseTextWidget extends StatelessWidget {
  const NoExerciseTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).exercise_removed,
      ),
    );
  }
}
