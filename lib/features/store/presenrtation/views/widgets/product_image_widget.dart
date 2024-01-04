import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    return Container(
      width: getWidht / 3.7,
      height: getHeight / 6.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 0.2),
        image: DecorationImage(
          image: FirebaseImageProvider(
            FirebaseUrl(image),
            options: const CacheOptions(
              checkForMetadataChange: false,
            ),
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
