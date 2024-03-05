import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';

import '../home_category_exercises_screen.dart';

class MoveHomeExerciseIconWidget extends StatelessWidget {
  const MoveHomeExerciseIconWidget({
    super.key,
    required this.model,
    required this.id,
  });
  final Data model;
  final String id;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return userType == UserType.admin
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                navigateTo(
                  context,
                  HomeCategoryExercisesScreen(
                    oldData: model,
                    id: id,
                  ),
                );
              },
              icon: const Icon(Icons.move_down_rounded),
              color: Colors.red,
            ),
          )
        : const SizedBox();
  }
}
