// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_without_vedio_screen.dart';
import 'package:tamrini/features/home/presentation/views/widgets/image_view_widget.dart';

import 'remove_exercise_icon_widget.dart';

class ExerciseCardWidget extends StatefulWidget {
  const ExerciseCardWidget({
    required this.exercise,
    Key? key,
    required this.isAll,
    required this.id,
  }) : super(key: key);
  final DataModel exercise;
  final bool isAll;
  final String id;

  @override
  State<ExerciseCardWidget> createState() => _ExerciseCardWidgetState();
}

class _ExerciseCardWidgetState extends State<ExerciseCardWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        if (widget.exercise.assets == null || widget.exercise.assets!.isEmpty) {
          navigateTo(
            context,
            DetailsWithoutVedioScreen(
              id: widget.exercise.id!,
              isAll: widget.isAll,
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
              ),
            );
          } else {
            navigateTo(
              context,
              DetailsWithoutVedioScreen(
                id: widget.exercise.id!,
                isAll: widget.isAll,
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
                            fontSize: 15.sm,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (userType == 'admin')
              RemoveExerciseIconWidget(
                model: widget.exercise,
                id: widget.id,
              ),
            if (userType == 'writer' && widget.exercise.writerUid == uid)
              RemoveExerciseIconWidget(
                model: widget.exercise,
                id: widget.id,
              ),
          ],
        ),
      ),
    );
  }
}
