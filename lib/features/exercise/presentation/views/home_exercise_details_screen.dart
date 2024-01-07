import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../data/models/home_exercise/exercise_model.dart';
import 'widgets/custom_image_slide_show.dart';

class HomeExerciseDetailsScreen extends StatelessWidget {
  const HomeExerciseDetailsScreen({Key? key, required this.model})
      : super(key: key);
  final Data model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).exDetails,
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      model.title ?? '',
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
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        """${(model.description)}""",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
