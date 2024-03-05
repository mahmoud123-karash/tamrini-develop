import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/views/new_section_screen.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/generated/l10n.dart';

import '../all_exercises_category_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.model,
    required this.isCourse,
    required this.oldData,
  });
  final ExerciseModel model;
  final bool isCourse;
  final DataModel? oldData;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    String exerciseId = CacheHelper.getData(key: 'exerciseId') ?? '';

    return GestureDetector(
      onTap: () {
        if (oldData != null) {
          AwesomeDialog(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            showCloseIcon: true,
            titleTextStyle: TextStyles.style17.copyWith(
              fontWeight: FontWeight.bold,
              color: appColor,
            ),
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            title: oldData!.title ?? '',
            desc: '${S.of(context).move_exercise_to_category}(${model.title})',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              ExerciseCubit.get(context).moveExercise(
                exerciseId: exerciseId,
                oldData: oldData!,
                newCategory: model,
                message: S.of(context).success_move_exercise,
              );
              Navigator.pop(context);
            },
          ).show();
        } else {
          saveExerciseId(model.id ?? '');
          navigateTo(
            context,
            AllExercisesCategoryScreen(
              title: model.title ?? '',
              isCourse: isCourse,
            ),
          );
        }
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
