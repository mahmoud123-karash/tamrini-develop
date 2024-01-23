import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/features/exercise/data/models/home_exercise/exercise_model.dart';

import '../home_exercise_details_screen.dart';
import 'custom_image_slide_show.dart';

class HomeExerciseItemWidget extends StatelessWidget {
  const HomeExerciseItemWidget({super.key, required this.model});
  final Data model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigateTo(context, HomeExerciseDetailsScreen(model: model));
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
                    model.assets == null || model.assets!.isEmpty
                        ? const SizedBox()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CustomImageSlideShow(
                              assets: model.assets!,
                              children: distributeAssets(model.assets!),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          model.title!,
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
                          vertical: 10.0, horizontal: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          model.description!,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15,
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
          ],
        ),
      ),
    );
  }
}
