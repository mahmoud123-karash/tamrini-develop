import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/add_diet_course_custom_widget.dart';
import 'widgets/new_diet_course_content_widget.dart';

class NewDietCourseScreen extends StatefulWidget {
  const NewDietCourseScreen(
      {super.key, required this.model, required this.logo});
  final TraineeModel model;
  final String logo;

  @override
  State<NewDietCourseScreen> createState() => _NewDietCourseScreenState();
}

class _NewDietCourseScreenState extends State<NewDietCourseScreen> {
  TextEditingController dietTitleController = TextEditingController();
  TextEditingController dietdurationController = TextEditingController();
  TextEditingController satDayController = TextEditingController();
  TextEditingController sunDayController = TextEditingController();
  TextEditingController monDayController = TextEditingController();
  TextEditingController tueDayController = TextEditingController();
  TextEditingController wenDayController = TextEditingController();
  TextEditingController thrusDayController = TextEditingController();
  TextEditingController friDayController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    dietTitleController.dispose();
    dietdurationController.dispose();
    satDayController.dispose();
    sunDayController.dispose();
    monDayController.dispose();
    tueDayController.dispose();
    wenDayController.dispose();
    thrusDayController.dispose();
    friDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: themeAppBar(S.of(context).add_new_diet_course,
          backgroundColor: ThemeCubit.get(context).themeColor),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: NewDietCourseContentWidget(
              logo: widget.logo,
              dietTitleController: dietTitleController,
              dietdurationController: dietdurationController,
              satDayController: satDayController,
              sunDayController: sunDayController,
              monDayController: monDayController,
              tueDayController: tueDayController,
              wenDayController: wenDayController,
              thrusDayController: thrusDayController,
              friDayController: friDayController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
            ),
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
                child: AddDietCourseCustomWidget(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      TraineeCubit.get(context).addDietCourse(
                        model: widget.model,
                        name: dietTitleController.text,
                        duration: dietdurationController.text,
                        satData: satDayController.text,
                        sunData: sunDayController.text,
                        monData: monDayController.text,
                        wenData: wenDayController.text,
                        tueData: tueDayController.text,
                        thrusData: thrusDayController.text,
                        friData: friDayController.text,
                      );
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
