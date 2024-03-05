import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/home_exercise/presentation/views/all_home_exercise_category_screen.dart';
import 'package:tamrini/features/home_exercise/presentation/views/new_home_section_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeCategoryItemWidget extends StatelessWidget {
  const HomeCategoryItemWidget({
    super.key,
    required this.model,
    required this.oldData,
    required this.id,
  });
  final HomeExerciseModel model;
  final Data? oldData;
  final String? id;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? "";
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
            title: oldData!.title,
            desc: '${S.of(context).move_exercise_to_category}(${model.title})',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              HomeExerciseCubit.get(context).moveExercise(
                id: id!,
                oldData: oldData!,
                newCategory: model,
                message: S.of(context).success_move_exercise,
              );
              Navigator.pop(context);
            },
          ).show();
        } else {
          navigateTo(
            context,
            AllHomeExerciseCategoryScreen(
              title: model.title ?? '',
              id: model.id ?? '',
              isAll: false,
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
              if (userType == UserType.admin)
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
