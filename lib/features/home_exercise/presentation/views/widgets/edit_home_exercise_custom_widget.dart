import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/presentation/views/new_home_exercise_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class EditHomeExerciseCustomButtonWidget extends StatelessWidget {
  const EditHomeExerciseCustomButtonWidget({super.key, required this.model});
  final Data model;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (userType == UserType.admin) const Divider(),
        if (userType == UserType.admin)
          customButton(
            onPressed: () {
              navigateToAndReplace(
                context,
                NewHomeExerciseScreen(model: model, id: model.sectionId ?? ''),
              );
            },
            lable: S.of(context).edit,
          ),
        if (userType == UserType.writer && model.writerUid == uid)
          const Divider(),
        if (userType == UserType.writer && model.writerUid == uid)
          customButton(
            onPressed: () {
              navigateToAndReplace(
                context,
                NewHomeExerciseScreen(model: model, id: model.sectionId ?? ''),
              );
            },
            lable: S.of(context).edit,
          )
      ],
    );
  }
}
