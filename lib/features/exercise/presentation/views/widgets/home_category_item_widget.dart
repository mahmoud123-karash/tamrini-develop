import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/data/models/home_exercise/home_exercise_model.dart';
import 'package:tamrini/features/exercise/presentation/views/all_home_exercise_category_screen.dart';

class HomeCategoryItemWidget extends StatelessWidget {
  const HomeCategoryItemWidget({
    super.key,
    required this.model,
  });
  final HomeExerciseModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            AllHomeExercisesCategoryScreen(
              model: model.data!,
              title: model.title ?? '',
            ));
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
