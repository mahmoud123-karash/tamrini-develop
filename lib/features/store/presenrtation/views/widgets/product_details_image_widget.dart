import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';

class ProductDetailsImageWidget extends StatelessWidget {
  const ProductDetailsImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image(
            image: FirebaseImageProvider(
              FirebaseUrl(image),
              options: const CacheOptions(
                checkForMetadataChange: false,
              ),
            ),
            fit: BoxFit.cover,
            width: getWidht / 2 - 20,
          ),
        ),
      ),
    );
  }
}
