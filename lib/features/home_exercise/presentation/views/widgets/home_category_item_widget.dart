import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';
import 'package:tamrini/features/home_exercise/presentation/views/all_home_exercise_category_screen.dart';
import 'package:tamrini/features/home_exercise/presentation/views/new_home_section_screen.dart';

class HomeCategoryItemWidget extends StatelessWidget {
  const HomeCategoryItemWidget({
    super.key,
    required this.model,
  });
  final HomeExerciseModel model;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            AllHomeExercisesCategoryScreen(
              models: model.data ?? [],
              title: model.title ?? '',
            ));
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
            image: model.image != ''
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
            children: [
              Expanded(
                child: AutoSizeText(
                  model.title ?? '',
                  maxLines: 2,
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
                    navigateTo(context, NewHomeSectionScreen(model: model));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.yellow,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
