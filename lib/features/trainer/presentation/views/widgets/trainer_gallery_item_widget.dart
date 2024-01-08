import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/generated/l10n.dart';

import 'image_slide_show_widget.dart';

class TrainerGalleryItemWidget extends StatelessWidget {
  const TrainerGalleryItemWidget(
      {super.key, required this.imageBefore, required this.imageAfter});
  final String imageBefore, imageAfter;

  @override
  Widget build(BuildContext context) {
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
                                image: imageBefore,
                                fit: BoxFit.contain,
                                text: S.of(context).before,
                              ),
                              ImageSlideShowWidget(
                                image: imageAfter,
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
        child: ImageSlideshow(
          width: double.infinity,
          height: 200,
          indicatorColor: Colors.blue,
          indicatorBackgroundColor: Colors.grey,
          autoPlayInterval: 0,
          isLoop: false,
          children: [
            ImageSlideShowWidget(
              image: imageBefore,
              fit: BoxFit.cover,
              text: S.of(context).before,
            ),
            ImageSlideShowWidget(
              image: imageAfter,
              fit: BoxFit.cover,
              text: S.of(context).after,
            ),
          ],
        ),
      ),
    );
  }
}
