import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_without_vedio_screen.dart';
import 'package:tamrini/features/home/presentation/views/widgets/image_view_widget.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';

class ExerciseItemWidget extends StatelessWidget {
  const ExerciseItemWidget(
      {super.key, required this.model, required this.width, required this.num});
  final DataModel model;
  final double width;
  final int num;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        if (model.assets == null || model.assets!.isEmpty) {
          navigateTo(
            context,
            DetailsWithoutVedioScreen(
              id: model.id!,
              isAll: false,
              isHome: false,
            ),
          );
        } else {
          if (checkVedioformat(model.assets ?? []) != '') {
            navigateTo(
              context,
              DetailsScreen(
                id: model.id!,
                vedio: checkVedioformat(model.assets ?? []),
                isAll: false,
                isHome: false,
              ),
            );
          } else {
            navigateTo(
              context,
              DetailsWithoutVedioScreen(
                id: model.id!,
                isAll: false,
                isHome: false,
              ),
            );
          }
        }
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ImageViewWidget(
                    width: width,
                    image: checkImageformat(
                      model.assets ?? [],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10),
                    child: SizedBox(
                      width: width,
                      child: Text(
                        model.title ?? '',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (num != 100)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () {
                  CourseCubit.get(context).removeExercise(
                    id: model.id ?? '',
                    index: num,
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
