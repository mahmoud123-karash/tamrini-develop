import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/new_exercise_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class EditExerciseCustomButtonWidget extends StatelessWidget {
  const EditExerciseCustomButtonWidget({super.key, required this.model});
  final DataModel model;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? "";
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (userType == UserType.admin) const Divider(),
        if (userType == UserType.admin)
          customButton(
            onPressed: () {
              navigateToAndReplace(
                context,
                NewExerciseScreen(model: model),
              );
            },
            lable: S.of(context).edit_exercise,
          ),
        if (userType == UserType.writer && model.writerUid == uid)
          const Divider(),
        if (userType == UserType.writer && model.writerUid == uid)
          customButton(
            onPressed: () {
              navigateToAndReplace(
                context,
                NewExerciseScreen(model: model),
              );
            },
            lable: S.of(context).edit_exercise,
          ),
      ],
    );
  }
}
