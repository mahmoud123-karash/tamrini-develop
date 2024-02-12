import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_without_vedio_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/add_rep_and_repeat_row_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/image_view_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_exercises_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_states.dart';

import 'remove_exercise_icon_widget.dart';

class ExerciseCardWidget extends StatefulWidget {
  const ExerciseCardWidget({
    required this.exercise,
    Key? key,
    required this.isAll,
    required this.id,
    this.isHome = false,
    required this.isCourse,
  }) : super(key: key);
  final DataModel exercise;
  final bool isAll, isHome;
  final String id;
  final bool isCourse;

  @override
  State<ExerciseCardWidget> createState() => _ExerciseCardWidgetState();
}

class _ExerciseCardWidgetState extends State<ExerciseCardWidget> {
  TextEditingController numRController = TextEditingController();
  TextEditingController numPController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');

    return BlocBuilder<CourseCubit, CourseStates>(
      builder: (context, state) {
        List<TraineeExerciseModel> list = CourseCubit.get(context).list;
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            if (widget.exercise.assets == null ||
                widget.exercise.assets!.isEmpty) {
              navigateTo(
                context,
                DetailsWithoutVedioScreen(
                  id: widget.exercise.id!,
                  isAll: widget.isAll,
                  isHome: widget.isHome,
                ),
              );
            } else {
              if (checkVedioformat(widget.exercise.assets ?? []) != '') {
                navigateTo(
                  context,
                  DetailsScreen(
                    id: widget.exercise.id!,
                    vedio: checkVedioformat(widget.exercise.assets ?? []),
                    isAll: widget.isAll,
                    isHome: widget.isHome,
                  ),
                );
              } else {
                navigateTo(
                  context,
                  DetailsWithoutVedioScreen(
                    id: widget.exercise.id!,
                    isAll: widget.isAll,
                    isHome: widget.isHome,
                  ),
                );
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.isCourse)
                          Checkbox(
                            value: list.any((element) =>
                                element.exerciseId == widget.exercise.id),
                            onChanged: (value) {
                              if (list.any((element) =>
                                  element.exerciseId == widget.exercise.id)) {
                                CourseCubit.get(context).unSelectExercise(
                                  id: widget.exercise.id ?? '',
                                );
                              } else {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  CourseCubit.get(context).selectExercise(
                                    model: TraineeExerciseModel(
                                      exerciseId: widget.exercise.id ?? '',
                                      setsNo: int.parse(numPController.text),
                                      repeatNo: int.parse(numRController.text),
                                    ),
                                  );
                                } else {
                                  autovalidateMode = AutovalidateMode.always;
                                  setState(() {});
                                }
                              }
                            },
                          ),
                        const SizedBox(
                          height: 5,
                        ),
                        ImageViewWidget(
                          width: width,
                          image: checkImageformat(
                            widget.exercise.assets ?? [],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              widget.exercise.title ?? '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: blackColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              widget.exercise.description ?? '',
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15.h,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade500,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        if (widget.isCourse)
                          AddRepAndRepeatRowWidget(
                            numRController: numRController,
                            numPController: numPController,
                            autovalidateMode: autovalidateMode,
                            formKey: formKey,
                          ),
                      ],
                    ),
                  ),
                ),
                if (!widget.isAll)
                  if (userType == 'admin')
                    RemoveExerciseIconWidget(
                      model: widget.exercise,
                      id: widget.id,
                    ),
                if (!widget.isAll)
                  if (userType == 'writer' && widget.exercise.writerUid == uid)
                    RemoveExerciseIconWidget(
                      model: widget.exercise,
                      id: widget.id,
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
