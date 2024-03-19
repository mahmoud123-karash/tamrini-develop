import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/course_custom_button_builder_widget.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/days_course_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/course_name_duration_colum_widget.dart';

class NewCourseScreen extends StatefulWidget {
  const NewCourseScreen({super.key, required this.model, required this.logo});
  final TraineeModel model;
  final String logo;

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
              child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              CirclarImageWidget(image: widget.logo, radius: 50),
              const SizedBox(
                height: 15,
              ),
              page == 0
                  ? CourseNameDurationColumWidget(
                      titleController: titleController,
                      durationController: durationController,
                      notesController: notesController,
                      autovalidateMode: autovalidateMode,
                      formKey: formKey,
                    )
                  : const DaysCourseWidget(),
            ],
          )),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: CourseCustomButtonBuilderWidget(
                  onPressed: () {
                    var cubit = CourseCubit.get(context);
                    if (page == 0) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        page++;
                        setState(() {});
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    } else {
                      if (cubit.checkThreeListsNotEmpty()) {
                        TraineeCubit.get(context).addNewCourse(
                          model: widget.model,
                          dayWeekExercises: DayWeekExercises(
                            sat: cubit.sutList,
                            mon: cubit.monList,
                            fri: cubit.friList,
                            sun: cubit.sunList,
                            thurs: cubit.thrueList,
                            tue: cubit.tueList,
                            wed: cubit.wenList,
                          ),
                          duration: durationController.text,
                          notes: notesController.text,
                          title: titleController.text,
                        );
                      } else {
                        showSnackBar(context, S.of(context).complete_lists);
                      }
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
