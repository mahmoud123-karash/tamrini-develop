// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/presentation/views/widgets/image_view_widget.dart';
import 'package:tamrini/features/suggest_exercise/data/models/suggest_model/suggest_model.dart';
import 'package:tamrini/features/suggest_exercise/presentation/views/suggested_exercise_details_screen.dart';

class SuggestedExerciseCardWidget extends StatelessWidget {
  const SuggestedExerciseCardWidget({required this.exercise, Key? key})
      : super(key: key);
  final SuggestModel exercise;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        navigateTo(context, SuggestedExerciseDetailsScreen(model: exercise));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    ImageViewWidget(
                      width: width,
                      image: exercise.image,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          exercise.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
