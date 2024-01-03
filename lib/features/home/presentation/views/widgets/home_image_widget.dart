import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';

class HomeImageWidget extends StatelessWidget {
  const HomeImageWidget({super.key, required this.image});
  final String image;

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
              width: getWidht - 70,
              height: getHeight * 0.3,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              Assets.imagesExercise,
              fit: BoxFit.cover,
              width: getWidht - 70,
              height: getHeight * 0.3,
            ),
          );
  }
}
