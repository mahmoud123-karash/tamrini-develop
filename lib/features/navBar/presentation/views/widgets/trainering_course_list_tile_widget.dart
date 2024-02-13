import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/features/trainee/presentation/views/training_course_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainingCourseListTileWidget extends StatelessWidget {
  const TrainingCourseListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String trainerId = CacheHelper.getData(key: 'trainerId') ?? '';

    return DrawerListTileWidget(
      onPressed: () {
        if (trainerId != '') {
          navigateTo(context, const TrainingCourseScreen());
        } else {
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
            title: S.of(context).you_unsub_with_trainer,
            desc: S.of(context).sub_with_trainer_and_try_again,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      },
      icon: Icons.track_changes_outlined,
      lable: S.of(context).training_course,
    );
  }
}
