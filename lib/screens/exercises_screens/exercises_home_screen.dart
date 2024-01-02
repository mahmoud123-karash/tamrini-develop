import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/exercise.dart';
import 'package:tamrini/provider/exercise_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/exercises_screens/Add_exercise_category_screen.dart';
import 'package:tamrini/screens/exercises_screens/edit_category_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class ExercisesHomeScreen extends StatefulWidget {
  final bool? isCourse;
  final String dayID;
  final bool? superSet;
  final Data? mainExercise;
  const ExercisesHomeScreen(
      {Key? key,
      this.isCourse = false,
      this.dayID = "",
      this.superSet = false,
      this.mainExercise})
      : super(key: key);

  @override
  State<ExercisesHomeScreen> createState() => _ExercisesHomeScreenState();
}

class _ExercisesHomeScreenState extends State<ExercisesHomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: SizedBox(child: adBanner() , height: 50 ,  width: 100.w ),
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("التمارين"),
      body: SingleChildScrollView(
        child: Consumer<ExerciseProvider>(builder: (context, _, child) {
          return _.isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Image.asset('assets/images/loading.gif',
                        height: 100.h, width: 100.w),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Provider.of<UserProvider>(context, listen: false).isAdmin
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 20),
                              child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  color: kSecondaryColor!,
                                  onPressed: () {
                                    To(const AddExerciseCategoryScreen());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "إضافة قسم جديد",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.isCourse!
                              ? _.moveToExercise(_.allExercises,
                                  isAll: true,
                                  isAdd: true,
                                  dayID: widget.dayID,
                                  superSet: widget.superSet,
                                  mainExercise: widget.mainExercise)
                              : _.moveToExercise(_.allExercises, isAll: true);
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          constraints: BoxConstraints(
                            minHeight: 100.spMax,
                            minWidth: 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/allExer.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "جميع التمارين",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          dragStartBehavior: DragStartBehavior.start,
                          itemCount: _.exercises.length,
                          itemBuilder: (BuildContext context, int index) {
                            _.exercises
                                .sort((a, b) => a.order!.compareTo(b.order!));
                            return GestureDetector(
                              onTap: () {
                                widget.isCourse!
                                    ? _.moveToExercise(
                                        _.exercises[index],
                                        isAdd: true,
                                        dayID: widget.dayID,
                                        superSet: widget.superSet,
                                        mainExercise: widget.mainExercise,
                                      )
                                    : _.moveToExercise(_.exercises[index]);

                                // To(ExerciseArticlesScreen(
                                //   // exercise: _.exercises[index],
                                // ));
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                constraints: const BoxConstraints(
                                  minHeight: 100,
                                  minWidth: 100,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black54, BlendMode.darken),
                                    image: _.exercises[index].image!.isNotEmpty
                                        ? FirebaseImageProvider(FirebaseUrl(
                                            _.exercises[index].image!))
                                        : const AssetImage(
                                                "assets/images/allExer.jpg")
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Spacer(),
                                      // Provider.of<UserProvider>(context,
                                      //             listen: false)
                                      //         .isAdmin
                                      //     ? IconButton(
                                      //         onPressed: () {
                                      //           Widget cancelButton = TextButton(
                                      //             child: const Text("إلغاء"),
                                      //             onPressed: () {
                                      //               pop();
                                      //             },
                                      //           );
                                      //           Widget continueButton = TextButton(
                                      //             child: const Text(
                                      //               "تأكيد الحذف",
                                      //               style:
                                      //                   TextStyle(color: Colors.red),
                                      //             ),
                                      //             onPressed: () {
                                      //               pop();
                                      //               _.deleteCategory(
                                      //                   id: _.exercises[index].id!);
                                      //             },
                                      //           );
                                      //
                                      //           showDialog(
                                      //               context: navigationKey
                                      //                   .currentState!.context,
                                      //               builder: (context) => AlertDialog(
                                      //                     title: const Text(
                                      //                       'تأكيد الحذف',
                                      //                       textAlign:
                                      //                           TextAlign.right,
                                      //                     ),
                                      //                     content: Text(
                                      //                       'هل انت متأكد من حذف قسم ${_.exercises[index].title} ؟',
                                      //                       textAlign:
                                      //                           TextAlign.right,
                                      //                     ),
                                      //                     actions: [
                                      //                       continueButton,
                                      //                       cancelButton,
                                      //                     ],
                                      //                     actionsAlignment:
                                      //                         MainAxisAlignment
                                      //                             .spaceEvenly,
                                      //                   ));
                                      //         },
                                      //         icon: const Icon(
                                      //           Icons.delete_forever,
                                      //           color: Colors.red,
                                      //           size: 30,
                                      //         ),
                                      //       )
                                      //     : const SizedBox(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              _.exercises[index].title!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .isAdmin
                                              ? IconButton(
                                                  onPressed: () {
                                                    To(EditEXECategoryScreen(
                                                      category:
                                                          _.exercises[index],
                                                    ));
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.yellow,
                                                    size: 30,
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width / 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
