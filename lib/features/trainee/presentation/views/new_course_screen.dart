import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/days_course_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/course_name_duration_colum_widget.dart';

class NewCourseScreen extends StatefulWidget {
  const NewCourseScreen({super.key});

  @override
  State<NewCourseScreen> createState() => _NewCourseScreenState();
}

class _NewCourseScreenState extends State<NewCourseScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();

  int page = 0;

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).add_new_course),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: page == 0
                ? CourseNameDurationColumWidget(
                    titleController: titleController,
                    durationController: durationController,
                    notesController: notesController,
                    autovalidateMode: autovalidateMode,
                    formKey: formKey,
                  )
                : const DaysCourseWidget(),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: customButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (page == 0) {
                        page++;
                        setState(() {});
                      } else {}
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  lable: page == 0 ? S.of(context).next : S.of(context).add,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
