import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';

class DietFoodImageWidget extends StatelessWidget {
  const DietFoodImageWidget(
      {super.key, required this.image, required this.fit});
  final String image;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: fit,
      image: FirebaseImageProvider(
        FirebaseUrl(
          image,
        ),
      ),
      loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
    );
  }
}
