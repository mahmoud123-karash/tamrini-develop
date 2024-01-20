import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/home_exercise.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/home_exercises_screens/edit_home_exercise_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/video_manager.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../../utils/distripute_assets.dart';
import '../../utils/regex.dart';
import '../../utils/widgets/custom_image_slide_show.dart';

class HomeExerciseArticlesDetailsScreen extends StatefulWidget {
  final Data exercise;
  final HomeExercise category;
  final bool isAll;

  const HomeExerciseArticlesDetailsScreen(
      {Key? key,
      required this.exercise,
      required this.category,
      required this.isAll})
      : super(key: key);

  @override
  State<HomeExerciseArticlesDetailsScreen> createState() =>
      _HomeExerciseArticlesDetailsScreenState();
}

class _HomeExerciseArticlesDetailsScreenState
    extends State<HomeExerciseArticlesDetailsScreen> {
  int _current = 0;
  VideoManager? videoManager;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> assets = [];
    if (widget.exercise.assets != null) {
      assets = distributeAssets(widget.exercise.assets! as List<String>);
    }
    return SafeArea(
      child: Scaffold(
        persistentFooterButtons: [adBanner()],
        appBar: globalAppBar("تفاصيل التمرين"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.exercise.title ?? '',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    widget.exercise.assets == null ||
                            widget.exercise.assets!.isEmpty
                        ? Container()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CustomImageSlideShow(
                              assets: widget.exercise.assets!,
                              onPageChanged: (value) {
                                setState(() {
                                  _current = value;
                                });
                              },
                              children: [
                                for (var i = 0;
                                    i < widget.exercise.assets!.length;
                                    i++)
                                  InkWell(
                                    onTap: () {
                                      if (widget.exercise.assets![i].contains(
                                          RegExp(RegexPatterns
                                              .allowedImageFormat))) {
                                        showDialog<dynamic>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return OrientationBuilder(
                                                builder:
                                                    (context, orientation) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return Scaffold(
                                                      appBar: AppBar(
                                                        backgroundColor:
                                                            Color(0xFFEFF2F7),
                                                        elevation: 0,
                                                        iconTheme:
                                                            const IconThemeData(
                                                                color: Color(
                                                                    0xFF003E4F)),
                                                        centerTitle: false,
                                                        title: Text(
                                                          widget.exercise
                                                                  .title ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            color: const Color(
                                                                0xff007c9d),
                                                          ),
                                                        ),
                                                      ),
                                                      body: Container(
                                                        // height: 1.sh,
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            CustomImageSlideShow(
                                                          height: 1.sh,
                                                          currentIndex:
                                                              _current,
                                                          assets: widget
                                                              .exercise.assets!,
                                                          children: assets,
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                              );
                                            });
                                      }
                                    },
                                    child: assets[i],
                                  ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            """${(widget.exercise.description)}""",
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Provider.of<UserProvider>(context, listen: false).isAdmin &&
                            !widget.isAll
                        ? MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: kSecondaryColor!,
                            onPressed: () {
                              To(EditHomeExerciseScreen(
                                exercise: widget.exercise,
                                category: widget.category,
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "تعديل",
                                  style: TextStyle(
                                      fontSize: 18.sp, color: Colors.white),
                                ),
                              ],
                            ))
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
