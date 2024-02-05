import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/home_exercise_body_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeExerciseDetailsScreen extends StatelessWidget {
  const HomeExerciseDetailsScreen({
    Key? key,
    required this.id,
    required this.isAll,
  }) : super(key: key);
  final String id;
  final bool isAll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).exDetails,
      ),
      body: HomeExerciseBodyWidget(
        id: id,
        isAll: isAll,
      ),
    );
  }
}
