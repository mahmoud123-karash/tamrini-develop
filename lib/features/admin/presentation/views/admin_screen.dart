import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/suggested_exercises_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).admin_control_pannel),
      body: Column(
        children: [
          DrawerListTileWidget(
            onPressed: () {
              navigateTo(context, const SuggestedExerciseScreen());
            },
            icon: Icons.fitness_center_outlined,
            lable: S.of(context).suggested_exercises,
          ),
        ],
      ),
    );
  }
}
