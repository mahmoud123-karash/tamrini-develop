import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';

import '../../../../../core/utils/distripute_assets.dart';

class SupplementImageSlideShowWidget extends StatelessWidget {
  const SupplementImageSlideShowWidget(
      {super.key, required this.images, required this.title});
  final List<String> images;
  final String title;

  @override
  Widget build(BuildContext context) {
    List<Widget> assets = [];
    assets = distributeAssets(
      images,
      fit: BoxFit.contain,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      width: double.infinity,
      child: ImageSlideshow(
        children: [
          for (var i = 0; i < images.length; i++)
            InkWell(
              onTap: () {
                if (images[i].contains(RegExp(
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
                                      color: const Color(
                                        0xff007c9d,
                                      ),
                                    ),
                                  ),
                                ),
                                body: Container(
                                  alignment: Alignment.center,
                                  child: ImageSlideshow(
                                    height: 1.sh,
                                    children: assets,
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
              child: assets[i],
            )
        ],
      ),
    );
  }
}
