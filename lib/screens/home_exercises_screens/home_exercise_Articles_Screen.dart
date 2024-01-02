import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/home_exercise.dart';
import 'package:tamrini/provider/home_exercise_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/home_exercises_screens/Add_home_exercise_screen.dart';
import 'package:tamrini/screens/home_exercises_screens/home_exercise_Article_details_Screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/distripute_assets.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../../utils/widgets/custom_image_slide_show.dart';

class HomeExerciseArticlesScreen extends StatefulWidget {
  final HomeExercise homeExercise;
  final bool isAll;

  const HomeExerciseArticlesScreen(
      {Key? key, this.isAll = false, required this.homeExercise})
      : super(key: key);

  @override
  State<HomeExerciseArticlesScreen> createState() =>
      _HomeExerciseArticlesScreenState();
}

class _HomeExerciseArticlesScreenState
    extends State<HomeExerciseArticlesScreen> {
  @override
  void dispose() {
    Provider.of<HomeExerciseProvider>(navigationKey.currentContext!,
            listen: false)
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
        persistentFooterButtons: [adBanner()],
        appBar: globalAppBar(widget.isAll
            ? "جميع التمارين المنزلية"
            : widget.homeExercise.title!),
        body: Consumer<HomeExerciseProvider>(builder: (context, _, child) {
          return _.isLoading
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
                      searchBar(_.searchController, (value) {
                        widget.isAll
                            ? _.searchAll()
                            : _.search(widget.homeExercise.title!);
                      }),
                      Provider.of<UserProvider>(context, listen: false)
                                  .isAdmin &&
                              !widget.isAll
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: kSecondaryColor!,
                                    onPressed: () {
                                      To(AddHomeExerciseScreen(
                                          category: widget.homeExercise));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            Icons.add_circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "إضافة تمرين",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ],
                            )
                          : const SizedBox(),
                      _.searchController.text.isNotEmpty &&
                              _.selectedExercise.isEmpty
                          ? const Center(
                              child: Text("لا يوجد تمارين منزلية بهذا الإسم"),
                            )
                          : _.selectedExercise == null ||
                                  _.selectedExercise.isEmpty
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
                                    if (_.selectedExercise[index].assets !=
                                        null) {
                                      assets = distributeAssets(_
                                          .selectedExercise[index]
                                          .assets! as List<String>);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          To(
                                            HomeExerciseArticlesDetailsScreen(
                                              category: widget.homeExercise,
                                              exercise:
                                                  _.selectedExercise[index],
                                              isAll: widget.isAll,
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              elevation: 7,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    _.selectedExercise[index]
                                                                    .assets ==
                                                                null ||
                                                            _
                                                                .selectedExercise[
                                                                    index]
                                                                .assets!
                                                                .isEmpty
                                                        ? const SizedBox()
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child:
                                                                CustomImageSlideShow(
                                                              assets: _
                                                                  .selectedExercise[
                                                                      index]
                                                                  .assets!,
                                                              children: assets,
                                                            ),
                                                          ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              right: 10),
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          _
                                                              .selectedExercise[
                                                                  index]
                                                              .title!,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10),
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          _
                                                              .selectedExercise[
                                                                  index]
                                                              .description!,
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 15.sm,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors
                                                                .grey.shade500,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Provider.of<UserProvider>(context,
                                                            listen: false)
                                                        .isAdmin &&
                                                    !widget.isAll
                                                ? Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Widget cancelButton =
                                                              TextButton(
                                                            child: const Text(
                                                                "إلغاء"),
                                                            onPressed: () {
                                                              pop();
                                                            },
                                                          );
                                                          Widget
                                                              continueButton =
                                                              TextButton(
                                                            child: const Text(
                                                                "تأكيد الحذف"),
                                                            onPressed: () {
                                                              pop();

                                                              _.deleteExercise(
                                                                  exercise:
                                                                      _.selectedExercise[
                                                                          index],
                                                                  category: widget
                                                                      .homeExercise);
                                                            },
                                                          );

                                                          showDialog(
                                                              context: navigationKey
                                                                  .currentState!
                                                                  .context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title:
                                                                            const Text(
                                                                          'تأكيد الحذف',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                        ),
                                                                        content:
                                                                            const Text(
                                                                          'هل انت متأكد من حذف التمرين المنزلي ؟',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                        ),
                                                                        actions: [
                                                                          cancelButton,
                                                                          continueButton,
                                                                        ],
                                                                        actionsAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                      ));
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete_forever,
                                                          color: Colors.red,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: _.selectedExercise.length,
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
