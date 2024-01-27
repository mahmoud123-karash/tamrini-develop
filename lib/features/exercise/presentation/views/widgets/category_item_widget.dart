import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/new_section_screen.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';

import '../all_exercises_category_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.model,
  });
  final ExerciseModel model;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');

    return GestureDetector(
      onTap: () {
        saveExerciseId(model.id ?? '');
        navigateTo(
          context,
          AllExercisesCategoryScreen(
            title: model.title ?? '',
          ),
        );
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        constraints: const BoxConstraints(
          minHeight: 100,
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
            image: model.image != null
                ? FirebaseImageProvider(
                    FirebaseUrl(model.image!),
                  ) as ImageProvider
                : const AssetImage(
                    Assets.imagesAllExer,
                  ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AutoSizeText(
                  model.title ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (userType == 'admin')
                GestureDetector(
                  onTap: () {
                    navigateTo(context, NewSectionScreen(model: model));
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.yellowAccent,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
