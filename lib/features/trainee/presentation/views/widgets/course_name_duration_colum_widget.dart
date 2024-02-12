import 'package:flutter/widgets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

class CourseNameDurationColumWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          children: [
            addTextField(
              lable: S.of(context).course_name,
              controller: titleController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            addTextField(
              keyboardType: TextInputType.number,
              lable: S.of(context).course_duration,
              controller: durationController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            addTextField(
              lable: S.of(context).course_notes,
              controller: notesController,
              context: context,
              autovalidateMode: autovalidateMode,
            )
          ],
        ),
      ),
    );
  }
}
