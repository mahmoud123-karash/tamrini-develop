import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return image != ''
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: FirebaseImageProvider(
                FirebaseUrl(image),
                options: const CacheOptions(
                  checkForMetadataChange: false,
                ),
              ),
              fit: BoxFit.cover,
              loadingBuilder:
                  (_, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const SizedBox(
                    height: 120,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              Assets.imagesExercise,
              fit: BoxFit.cover,
            ),
          );
  }
}
