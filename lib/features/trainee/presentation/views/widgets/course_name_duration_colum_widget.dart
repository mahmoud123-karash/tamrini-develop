import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class CourseNameDurationColumWidget extends StatefulWidget {
  const CourseNameDurationColumWidget({
    super.key,
    required this.titleController,
    required this.durationController,
    required this.notesController,
    required this.autovalidateMode,
    required this.formKey,
  });

  final TextEditingController titleController;
  final TextEditingController durationController;
  final TextEditingController notesController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;

  @override
  State<CourseNameDurationColumWidget> createState() =>
      _CourseNameDurationColumWidgetState();
}

class _CourseNameDurationColumWidgetState
    extends State<CourseNameDurationColumWidget> {
  bool isNote = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          children: [
            themeTextField(
              color: ThemeCubit.get(context).themeColor,
              lable: S.of(context).course_name,
              controller: widget.titleController,
              context: context,
              autovalidateMode: widget.autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            themeTextField(
              color: ThemeCubit.get(context).themeColor,
              keyboardType: TextInputType.number,
              lable: S.of(context).course_duration,
              controller: widget.durationController,
              context: context,
              autovalidateMode: widget.autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            CheckboxListTile(
              activeColor: ThemeCubit.get(context).themeColor,
              title: Text(
                S.of(context).course_notes,
                style: TextStyles.style14.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ThemeCubit.get(context).themeColor,
                ),
              ),
              value: isNote,
              onChanged: (value) {
                isNote = value ?? false;
                setState(() {});
              },
            ),
            const SizedBox(
              height: 15,
            ),
            if (isNote)
              themeTextField(
                color: ThemeCubit.get(context).themeColor,
                lable: S.of(context).course_notes,
                controller: widget.notesController,
                context: context,
                autovalidateMode: widget.autovalidateMode,
              )
          ],
        ),
      ),
    );
  }
}
