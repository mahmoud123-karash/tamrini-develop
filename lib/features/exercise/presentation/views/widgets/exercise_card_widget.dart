// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_without_vedio_screen.dart';
import 'package:tamrini/features/home/presentation/views/widgets/image_view_widget.dart';

class ExerciseCardWidget extends StatefulWidget {
  const ExerciseCardWidget({required this.exercise, Key? key})
      : super(key: key);
  final DataModel exercise;

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
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        if (widget.exercise.assets != null ||
            widget.exercise.assets!.isNotEmpty) {
          if (widget.exercise.assets!.length == 2) {
            navigateTo(
              context,
              DetailsScreen(
                  model: widget.exercise, vedio: widget.exercise.assets![1]),
            );
          }
          if (widget.exercise.assets!.length == 1 &&
              checkVedioformat(widget.exercise.assets!) != '') {
            navigateTo(
              context,
              DetailsScreen(
                model: widget.exercise,
                vedio: widget.exercise.assets!.first,
              ),
            );
          }
          if (widget.exercise.assets!.length == 1 &&
              checkVedioformat(widget.exercise.assets!) == '') {
            navigateTo(
                context, DetailsWithoutVedioScreen(model: widget.exercise));
          }
        } else {
          navigateTo(
              context, DetailsWithoutVedioScreen(model: widget.exercise));
        }
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
                      image: widget.exercise.assets != null ||
                              widget.exercise.assets!.isNotEmpty
                          ? widget.exercise.assets!.length == 2
                              ? widget.exercise.assets!.first
                              : checkVedioformat(widget.exercise.assets!) == ''
                                  ? widget.exercise.assets!.first
                                  : ''
                          : '',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.exercise.title ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}
