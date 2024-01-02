import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/model/exercise.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/exercises_screens/edit_exercise_screen.dart';
import 'package:tamrini/utils/constants.dart';
import 'package:tamrini/utils/video_manager.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

import '../../utils/distripute_assets.dart';
import '../../utils/regex.dart';
import '../../utils/widgets/custom_image_slide_show.dart';

class ExerciseArticlesDetailsScreen extends StatefulWidget {
  final Data exercise;
  final Exercise category;
  final bool isAll;
  final Data? superSetExercise;

  const ExerciseArticlesDetailsScreen({
    Key? key,
    required this.exercise,
    required this.category,
    required this.isAll,
    this.superSetExercise,
  }) : super(key: key);

  @override
  State<ExerciseArticlesDetailsScreen> createState() =>
      _ExerciseArticlesDetailsScreenState();
}

class _ExerciseArticlesDetailsScreenState
    extends State<ExerciseArticlesDetailsScreen> {
  VideoManager? videoManager;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _imgIndex = 0;
    List<Widget> assets = [];
    if (widget.exercise.assets != null) {
      assets = distributeAssets(widget.exercise.assets! as List<String>);
    }

    return Scaffold(
      persistentFooterButtons: [adBanner()],
      appBar: globalAppBar("تفاصيل التمرين"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            // constraints:  BoxConstraints(
            //   minHeight: MediaQuery.of(context).size.height,
            // ),
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
                  ArticleView(exercise: widget.exercise),
                  if (widget.superSetExercise != null) ...[
                    const Divider(color: Colors.white,),
                    Text(
                      'التمرين الثاني',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0xff007c9d),
                      ),
                    ),
                    ArticleView(exercise: widget.superSetExercise!),
                  ],
                  Provider.of<UserProvider>(context, listen: false).isAdmin &&
                          !widget.isAll
                      ? MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: kSecondaryColor!,
                          onPressed: () {
                            To(EditExerciseScreen(
                              exercise: widget.exercise,
                              categoryID: widget.category,
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
    );
  }
}

class ArticleView extends StatelessWidget {
  final Data exercise;

  const ArticleView({required this.exercise, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> assets = [];
    if (exercise.assets != null) {
      assets = distributeAssets(exercise.assets! as List<String>);
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            exercise.title ?? '',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        exercise.assets == null || exercise.assets!.isEmpty
            ? Container()
            : ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CustomImageSlideShow(
                  assets: exercise.assets!,
                  onPageChanged: (value) {},
                  children: [
                    for (var i = 0; i < exercise.assets!.length; i++)
                      InkWell(
                        onTap: () {
                          if (exercise.assets![i].contains(
                              RegExp(RegexPatterns.allowedImageFormat))) {
                            showDialog<dynamic>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return OrientationBuilder(
                                    builder: (context, orientation) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return Scaffold(
                                          appBar: AppBar(
                                            backgroundColor: Color(0xFFEFF2F7),
                                            elevation: 0,
                                            iconTheme: const IconThemeData(
                                                color: Color(0xFF003E4F)),
                                            centerTitle: false,
                                            title: Text(
                                              exercise.title ?? '',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                color: const Color(0xff007c9d),
                                              ),
                                            ),
                                          ),
                                          body: Container(
                                            // height: 1.sh,
                                            alignment: Alignment.center,
                                            child: CustomImageSlideShow(
                                              height: 1.sh,
                                              assets: exercise.assets!,
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
                      )
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
                """${(exercise.description)}""",
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
