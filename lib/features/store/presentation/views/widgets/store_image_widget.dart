import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';

class StoreImageWidget extends StatelessWidget {
  const StoreImageWidget({super.key, required this.image, required this.width});
  final String image;
  final double width;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    return image != ''
        ? ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(
              image: FirebaseImageProvider(
                FirebaseUrl(image),
                options: const CacheOptions(
                  checkForMetadataChange: false,
                ),
              ),
              fit: BoxFit.cover,
              width: width,
              height: getHeight * 0.3,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              Assets.imagesWhey,
              fit: BoxFit.cover,
              width: getWidht,
              height: getHeight * 0.3,
            ),
          );
  }
}
