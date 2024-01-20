import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/exercise.dart';
import 'package:tamrini/model/trainee.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/screens/exercises_screens/exercise_Article_details_screen.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../../model/trainee_exercise.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Course course;

  const CourseDetailsScreen({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar('تفاصيل الكورس'),
      body: Consumer<TraineeProvider>(builder: (context, _, child) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 24),
                CourseDayExercisesCard(
                  exercises: course.dayWeekExercises!.sat!,
                  dayLabel: 'يوم السبت',
                ),
                CourseDayExercisesCard(
                  exercises: course.dayWeekExercises!.sun!,
                  dayLabel: 'يوم الأحد',
                ),
                CourseDayExercisesCard(
                  exercises: course.dayWeekExercises!.mon!,
                  dayLabel: 'يوم الإثنين',
                ),
                CourseDayExercisesCard(
                  exercises: course.dayWeekExercises!.tue!,
                  dayLabel: 'يوم الثلاثاء',
                ),
                CourseDayExercisesCard(
                  exercises: course.dayWeekExercises!.wed!,
                  dayLabel: 'يوم الأربعاء',
                ),
                CourseDayExercisesCard(
                  exercises: course.dayWeekExercises!.thurs!,
                  dayLabel: 'يوم الخميس',
                ),
                CourseDayExercisesCard(
                  exercises: course.dayWeekExercises!.fri!,
                  dayLabel: 'يوم الجمعة',
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CourseDayExercisesCard extends StatelessWidget {
  final String dayLabel;
  final List<TraineeExercise> exercises;

  const CourseDayExercisesCard(
      {required this.exercises, required this.dayLabel, Key? key})
      : super(key: key);

  String _getCardTitle(TraineeExercise traineeExercise) {
    return '${traineeExercise.exercise!.title!} ${traineeExercise.superSetExercise != null ? (' +  ${traineeExercise.superSetExercise!.title!}') : ''}';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            Text(dayLabel),
          ],
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  To(ExerciseArticlesDetailsScreen(
                      exercise: exercises[index].exercise!,
                      superSetExercise: exercises[index].superSetExercise,
                      category: Exercise(id: "0"),
                      isAll: true));
                },
                title: Text(_getCardTitle((exercises[index]))),
                subtitle: Column(
                  children: [
                    Text(exercises[index].exercise!.description!,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              const TextSpan(text: 'عدد المجموعات: '),
                              TextSpan(
                                  text: exercises[index].setsNo.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              const TextSpan(text: 'عدد مرات التكرار: '),
                              TextSpan(
                                  text: exercises[index].repeatNo.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        )
                        // Text('${course.dayWeekExercises!.sat![index].setsNo}عدد المجموعات: '),
                      ],
                    )
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
          itemCount: exercises.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
