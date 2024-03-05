import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/gallery_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/remove_gallery_icon_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'image_slide_show_widget.dart';

class TrainerGalleryItemWidget extends StatelessWidget {
  const TrainerGalleryItemWidget({
    super.key,
    required this.trainer,
    required this.model,
    this.isExample = false,
  });
  final TrainerModel trainer;
  final GalleryModel model;
  final bool isExample;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
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
                          backgroundColor: const Color(0xFFEFF2F7),
                          elevation: 0,
                          iconTheme:
                              const IconThemeData(color: Color(0xFF003E4F)),
                          centerTitle: false,
                          title: Text(
                            S.of(context).trainer_gallery,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xff007c9d),
                            ),
                          ),
                        ),
                        body: Container(
                          alignment: Alignment.center,
                          child: ImageSlideshow(
                            height: 1.sh,
                            children: [
                              ImageSlideShowWidget(
                                image: model.before,
                                fit: BoxFit.contain,
                                text: S.of(context).before,
                              ),
                              ImageSlideShowWidget(
                                image: model.after,
                                fit: BoxFit.contain,
                                text: S.of(context).after,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
        child: Stack(
          alignment: Intl.getCurrentLocale() == 'ar'
              ? Alignment.topRight
              : Alignment.topLeft,
          children: [
            ImageSlideshow(
              width: double.infinity,
              height: 200,
              indicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              autoPlayInterval: 0,
              isLoop: false,
              children: [
                ImageSlideShowWidget(
                  image: model.before,
                  fit: BoxFit.cover,
                  text: S.of(context).before,
                ),
                ImageSlideShowWidget(
                  image: model.after,
                  fit: BoxFit.cover,
                  text: S.of(context).after,
                ),
              ],
            ),
            if (!isExample)
              if (trainer.uid == uid && userType == UserType.trainer)
                RemoveGalleryIconWidget(trainer: trainer, model: model),
          ],
        ),
      ),
    );
  }
}
