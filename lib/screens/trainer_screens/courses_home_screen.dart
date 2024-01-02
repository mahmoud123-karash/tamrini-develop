import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/screens/courses_screen/courses_details_screen.dart';
import 'package:tamrini/screens/trainer_screens/add_course_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class CoursesHomeScreen extends StatelessWidget {
  const CoursesHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: globalAppBar('الكورسات'),
        body: Consumer<TraineeProvider>(
          builder: (context, _, child) {
            return _.isLoading
                ? Center(
                    child: Image.asset('assets/images/loading.gif',
                        height: 100.h, width: 100.w),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: _.selectedTrainee!.courses == null ||
                              _.selectedTrainee!.courses!.isEmpty
                          ? [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: kSecondaryColor!,
                                    onPressed: () {
                                      To(AddCourseScreen());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.add_circle,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "اضافة كورس جديد",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                              // const Spacer(),
                              const Center(
                                  child: Text('لا يوجد كورسات  حاليا')),
                              // const Spacer(),
                            ]
                          : [
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: kSecondaryColor!,
                                    onPressed: () {
                                      _.exerciseProvider.fetchAndSetExercise();
                                      To(AddCourseScreen());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.add_circle,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "اضافة كورس جديد",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(height: 24),
                              ListView.builder(
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        To(CourseDetailsScreen(
                                          course: _
                                              .selectedTrainee!.courses![index],
                                        ));
                                      },
                                      title: Text(_.selectedTrainee!
                                              .courses![index].title ??
                                          ''),
                                      subtitle: Text(
                                        DateFormat('yyyy-MM-dd').format(_
                                                    .selectedTrainee!
                                                    .courses![index]
                                                    .createdAt ==
                                                null
                                            ? DateTime.now()
                                            : DateTime.parse(_.selectedTrainee!
                                                .courses![index].createdAt!
                                                .toDate()
                                                .toString())),
                                      ),

                                      // subtitle: Text(_.selectedTrainee!.exercises![index].!),
                                      // isThreeLine: true,
                                    ),
                                  );
                                },
                                itemCount: _.selectedTrainee!.courses!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ],
                    ),
                  );
          },
        ));
  }
}
