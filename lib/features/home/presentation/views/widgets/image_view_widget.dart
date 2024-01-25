import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({super.key, required this.image, required this.width});
  final String image;
  final double width;

  @override
  Widget build(BuildContext context) {
    var hieght = MediaQuery.of(context).size.height;
    return image != ''
        ? imageProviderWidget(
            height: hieght / 4,
            width: width,
            imageProvider: FirebaseImageProvider(
              FirebaseUrl(image),
              options: const CacheOptions(
                checkForMetadataChange: false,
              ),
            ),
          )
        : imageProviderWidget(
            height: hieght / 4,
            width: width,
            imageProvider: const AssetImage(
              Assets.imagesExercise,
            ),
          );
  }
}
