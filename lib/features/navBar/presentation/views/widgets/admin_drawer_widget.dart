import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/suggested_exercises_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class AdminDrawerWidegt extends StatelessWidget {
  const AdminDrawerWidegt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerListTileWidget(
          onPressed: () {
            navigateTo(context, const SuggestedExerciseScreen());
          },
          icon: Icons.fitness_center_outlined,
          lable: S.of(context).suggested_exercises,
        ),
      ],
    );
  }
}
