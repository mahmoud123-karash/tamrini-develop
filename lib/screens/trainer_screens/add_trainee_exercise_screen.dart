import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/exercise_provider.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/screens/exercises_screens/exercises_home_screen.dart';
import 'package:tamrini/utils/distripute_assets.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../../model/exercise.dart';
import '../../model/trainee_exercise.dart';
import '../../utils/widgets/custom_image_slide_show.dart';

class AddTraineeExerciseScreen extends StatefulWidget {
  // final Course course;
  final String dayID;
  final Exercise exercise;
  final bool isAll;
  final bool? superSet;

  const AddTraineeExerciseScreen({
    Key? key,
    // required this.exercise,
    required this.dayID,
    required this.exercise,
    required this.isAll,
    this.superSet,
    // required this.course
  }) : super(key: key);

  @override
  State<AddTraineeExerciseScreen> createState() => _AddTraineeExerciseScreen();
}

class _AddTraineeExerciseScreen extends State<AddTraineeExerciseScreen> {
  @override
  void dispose() {
    Provider.of<ExerciseProvider>(navigationKey.currentContext!, listen: false)
        .clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: globalAppBar("التمارين"),
        body: Consumer<TraineeProvider>(builder: (context, _, child) {
          return _.exerciseProvider.isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Image.asset('assets/images/loading.gif',
                        height: 100.h, width: 100.w),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      searchBar(_.exerciseProvider.searchController, (value) {
                        widget.isAll
                            ? _.exerciseProvider.searchAll()
                            : _.exerciseProvider.search(widget.exercise.id);
                        _.exerciseProvider.searchAll();
                      }),
                      (_.exerciseProvider.selectedExercise == null ||
                                  _.exerciseProvider.selectedExercise
                                      .isEmpty) &&
                              !_.exerciseProvider.searchController.text.isEmpty
                          ? const Center(
                              child: Text("لا يوجد تمارين بهذا الإسم"),
                            )
                          : _.exerciseProvider.selectedExercise == null ||
                                  _.exerciseProvider.selectedExercise.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                              2 -
                                          100.h),
                                  child: const Center(
                                    child: Text('لا يوجد تمارين'),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    List<Widget> assets = [];
                                    if (_.exerciseProvider
                                            .selectedExercise[index].assets !=
                                        null) {
                                      assets = distributeAssets(_
                                          .exerciseProvider
                                          .selectedExercise[index]
                                          .assets! as List<String>);
                                    }
                                    return ExerciseCard(
                                      dayID: widget.dayID,
                                      index: index,
                                      assets: assets,
                                      traineeProvider: _,
                                    );
                                  },
                                  itemCount: _
                                      .exerciseProvider.selectedExercise.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 5.h,
                                    );
                                  },
                                )
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final int index;
  final String dayID;
  final List<Widget> assets;
  final TraineeProvider traineeProvider;

  const ExerciseCard(
      {required this.dayID,
      required this.index,
      required this.assets,
      required this.traineeProvider,
      Key? key})
      : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool superSetSwitchValue = false;
  bool showSuperSetSwitch = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController setsNoController = TextEditingController();

  TextEditingController repeatNoController = TextEditingController();

  void addExerciseToTrainee(TraineeProvider _, index) {
    final isValid = _formKey.currentState!.validate();
    _formKey.currentState!.save();

    if (!isValid) {
      return;
    }
    _.addExerciseToTrainee(
        TraineeExercise(
          exercise: _.exerciseProvider.selectedExercise[index],
          setsNo: int.parse(setsNoController.text),
          repeatNo: int.parse(repeatNoController.text),
        ),
        widget.dayID);

    setState(() {
      showSuperSetSwitch = true;
    });
  }

  void removeExerciseFromTrainee() {
    widget.traineeProvider.removeExerciseFromTrainee(
      widget.traineeProvider.exerciseProvider.selectedExercise[widget.index],
      widget.dayID,
    );

    setState(() {
      showSuperSetSwitch = false;
    });
  }

  void removeSuperSetExerciseFromTrainee() {
    widget.traineeProvider.removeSuperSetFromExercise(
      widget.traineeProvider.exerciseProvider.selectedExercise[widget.index],
      widget.dayID,
    );

  }

  @override
  void dispose() {
    setsNoController.dispose();
    repeatNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            widget.traineeProvider.newDayWeekExercises[widget.dayID]!
                    .map((traineeExercise) => traineeExercise.exercise)
                    .contains(widget.traineeProvider.exerciseProvider
                        .selectedExercise[widget.index])
                ? widget.traineeProvider.removeExerciseFromTrainee(
                    widget.traineeProvider.exerciseProvider
                        .selectedExercise[widget.index],
                    widget.dayID)
                : addExerciseToTrainee(widget.traineeProvider, widget.index);
          },
          child: Stack(
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
                      widget.traineeProvider.exerciseProvider
                                      .selectedExercise![widget.index].assets ==
                                  null ||
                              widget
                                  .traineeProvider
                                  .exerciseProvider
                                  .selectedExercise[widget.index]
                                  .assets!
                                  .isEmpty
                          ? const SizedBox()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CustomImageSlideShow(
                                assets: widget.traineeProvider.exerciseProvider
                                    .selectedExercise[widget.index].assets!,
                                children: widget.assets,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.traineeProvider.exerciseProvider
                                .selectedExercise[widget.index].title!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.traineeProvider.exerciseProvider
                                .selectedExercise[widget.index].description!,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15.sm,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                autofocus: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                controller: setsNoController,
                                decoration: const InputDecoration(
                                  labelText: 'عدد المجموعات',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _formKey.currentState!.validate();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Flexible(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                controller: repeatNoController,
                                decoration: const InputDecoration(
                                  labelText: 'عدد مرات التكرار',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                onChanged: (idNumber) {
                                  _formKey.currentState!.validate();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      if (showSuperSetSwitch == true)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.sports_gymnastics,
                                  ),
                                  SizedBox(
                                    width: 15.h,
                                  ),
                                  Text(
                                    'سوبر سيت',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'cairo',
                                    ),
                                  ),
                                  const Spacer(),
                                  CupertinoSwitch(
                                    value: superSetSwitchValue,
                                    onChanged: (value) {
                                      if (value == true) {
                                        // showDialog<dynamic>(
                                        //     context: context,
                                        //     barrierDismissible: false,
                                        //     builder: (BuildContext context) {
                                        //       return ExercisesHomeScreen(
                                        //         isCourse: true,
                                        //         dayID: widget.dayID,
                                        //       );
                                        //     });

                                        To(ExercisesHomeScreen(
                                          isCourse: true,
                                          dayID: widget.dayID,
                                          mainExercise: widget
                                              .traineeProvider
                                              .exerciseProvider
                                              .selectedExercise[widget.index],
                                          superSet: true,
                                        ));
                                      } else {
                                        // remove superset
                                        removeSuperSetExerciseFromTrainee();
                                      }
                                      setState(() {
                                        superSetSwitchValue = value;
                                      });
                                    },
                                    // trackColor:
                                    //     Colors.grey.shade200.withOpacity(0.2),
                                  ),
                                ],
                              ),
                              if (widget
                                          .traineeProvider
                                          .newDayWeekExercises[widget.dayID]
                                          ?.isNotEmpty ==
                                      true &&
                                  widget.traineeProvider.exerciseProvider
                                      .selectedExercise.isNotEmpty)
                                Text(
                                  widget.traineeProvider
                                          .newDayWeekExercises[widget.dayID]!
                                          .firstWhere((traineeExercise) =>
                                              traineeExercise.exercise!.id ==
                                              widget
                                                  .traineeProvider
                                                  .exerciseProvider
                                                  .selectedExercise[
                                                      widget.index]
                                                  .id)
                                          .superSetExercise
                                          ?.title ??
                                      '',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'cairo',
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Checkbox(
                    value: widget
                        .traineeProvider.newDayWeekExercises[widget.dayID]!
                        .map((traineeExercise) => traineeExercise.exercise)
                        .contains(widget.traineeProvider.exerciseProvider
                            .selectedExercise[widget.index]),
                    onChanged: (value) {
                      value != true
                          ? removeExerciseFromTrainee()
                          : addExerciseToTrainee(
                              widget.traineeProvider, widget.index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
