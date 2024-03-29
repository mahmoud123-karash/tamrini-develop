import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class NewDietCourseContentWidget extends StatelessWidget {
  const NewDietCourseContentWidget({
    super.key,
    required this.dietTitleController,
    required this.dietdurationController,
    required this.satDayController,
    required this.sunDayController,
    required this.monDayController,
    required this.tueDayController,
    required this.wenDayController,
    required this.thrusDayController,
    required this.friDayController,
    required this.autovalidateMode,
    required this.formKey,
    required this.logo,
  });
  final TextEditingController dietTitleController;
  final TextEditingController dietdurationController;
  final TextEditingController satDayController;
  final TextEditingController sunDayController;
  final TextEditingController monDayController;
  final TextEditingController tueDayController;
  final TextEditingController wenDayController;
  final TextEditingController thrusDayController;
  final TextEditingController friDayController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;
  final String logo;

  @override
  Widget build(BuildContext context) {
    Color themeColor = ThemeCubit.get(context).themeColor;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            if (logo != '') CirclarImageWidget(image: logo, radius: 50),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              lable: S.of(context).diet_name,
              controller: dietTitleController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              keyboardType: TextInputType.number,
              lable: S.of(context).diet_duration,
              controller: dietdurationController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              lable: S.of(context).sut,
              controller: satDayController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              lable: S.of(context).sun,
              controller: sunDayController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              lable: S.of(context).mon,
              controller: monDayController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              lable: S.of(context).tue,
              controller: tueDayController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              lable: S.of(context).wed,
              controller: wenDayController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              lable: S.of(context).thurs,
              controller: thrusDayController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: themeColor,
              lable: S.of(context).fri,
              controller: friDayController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
          ],
        ),
      ),
    );
  }
}
