import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/custom_image_slide_show.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';

class HomeExerciseDetailsContentWidget extends StatelessWidget {
  const HomeExerciseDetailsContentWidget({
    super.key,
    required this.model,
    this.player,
  });
  final Data model;
  final Widget? player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: Intl.getCurrentLocale() == 'en'
                  ? TextAlign.end
                  : TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          model.assets.isEmpty
              ? const SizedBox()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CustomImageSlideShow(
                    assets: model.assets,
                    children: distributeAssets(
                      model.assets,
                      player: player,
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                (model.description),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
