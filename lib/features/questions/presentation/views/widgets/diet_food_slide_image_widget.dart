import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/diet_food_image_widget.dart';

class DietFoodSlideImageWidget extends StatelessWidget {
  const DietFoodSlideImageWidget(
      {super.key, required this.images, required this.title});
  final List<String> images;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: ImageSlideshow(
        children: List.generate(
          images.length,
          (index) => InkWell(
            onTap: () {
              if (images[index].contains(RegExp(
                  "[^\\s]+(.*?)\\.(jpg|jpeg|png|JPG|JPEG|PNG|WEBP|webp|tiff|Tiff|TIFF|GIF|gif|bmp|BMP|svg|SVG)"))) {
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
                                iconTheme: const IconThemeData(
                                    color: Color(0xFF003E4F)),
                                centerTitle: false,
                                title: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: const Color(0xff007c9d),
                                  ),
                                ),
                              ),
                              body: Container(
                                alignment: Alignment.center,
                                child: ImageSlideshow(
                                  initialPage: 0,
                                  height: 1.sh,
                                  children: List.generate(
                                    images.length,
                                    (index) => DietFoodImageWidget(
                                      image: images[index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }
            },
            child: DietFoodImageWidget(
              image: images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
