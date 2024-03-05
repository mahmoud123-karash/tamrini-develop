import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/home/presentation/views/widgets/image_view_widget.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/presentation/views/home_exercise_details_with_youtub_screen.dart';

import '../home_exercise_details_screen.dart';
import 'remove_home_exercise_icon_widget.dart';

class HomeExerciseItemWidget extends StatelessWidget {
  const HomeExerciseItemWidget({
    super.key,
    required this.model,
    required this.isAll,
  });
  final Data model;
  final bool isAll;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          String vedio = checkVedioformat(model.assets);
          if (vedio != '') {
            navigateTo(
              context,
              HomeExerciseDetailsWithYoutubScreen(
                vedio: vedio,
                id: model.id,
                isAll: isAll,
              ),
            );
          } else {
            navigateTo(
              context,
              HomeExerciseDetailsScreen(isAll: isAll, id: model.id),
            );
          }
        },
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
                    model.assets.isEmpty
                        ? const SizedBox()
                        : ImageViewWidget(
                            width: width,
                            image: checkImageformat(
                              model.assets,
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          model.title,
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
                          model.description,
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
            if (!isAll) RemoveWidget(model: model),
          ],
        ),
      ),
    );
  }
}

class RemoveWidget extends StatelessWidget {
  const RemoveWidget({super.key, required this.model});
  final Data model;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return Column(
      children: [
        if (userType == UserType.admin)
          RemoveHomeExerciseIconWidget(model: model),
        if (userType == UserType.writer && model.writerUid == uid)
          RemoveHomeExerciseIconWidget(model: model),
      ],
    );
  }
}
