import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'show_gym_images_scaffold_widget.dart';

class GymSlideShowImagesWidget extends StatefulWidget {
  const GymSlideShowImagesWidget(
      {super.key, required this.assets, required this.name});
  final List<String> assets;
  final String name;

  @override
  State<GymSlideShowImagesWidget> createState() =>
      _GymSlideShowImagesWidgetState();
}

class _GymSlideShowImagesWidgetState extends State<GymSlideShowImagesWidget> {
  int imgIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: ImageSlideshow(
        onPageChanged: (value) {
          imgIndex = value;
          setState(() {});
        },
        children: [
          for (var i = 0; i < widget.assets.length; i++)
            InkWell(
              onTap: () {
                if (widget.assets[i].contains(RegExp(
                    "[^\\s]+(.*?)\\.(jpg|jpeg|png|JPG|JPEG|PNG|WEBP|webp|tiff|Tiff|TIFF|GIF|gif|bmp|BMP|svg|SVG)"))) {
                  showDialog<dynamic>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return OrientationBuilder(
                        builder: (context, orientation) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return ShowGymImagesScaffoldWidget(
                                assets: widget.assets,
                                name: widget.name,
                                imgIndex: imgIndex,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
              child: Image(
                image: FirebaseImageProvider(
                  FirebaseUrl(widget.assets[i]),
                  options: const CacheOptions(
                    checkForMetadataChange: false,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            )
        ],
      ),
    );
  }
}
