import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/exercise/presentation/views/all_exercises_category_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.model,
  });
  final ExerciseModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, AllExercisesCategoryScreen(model: model));
      },
      child: Container(
        alignment: Alignment.topRight,
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
            image: model.image != ''
                ? FirebaseImageProvider(
                    FirebaseUrl(model.image!),
                  ) as ImageProvider
                : const AssetImage(
                    "assets/images/allExer.jpg",
                  ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      model.title ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
