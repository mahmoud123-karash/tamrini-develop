import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class ProductDetailsImageWidget extends StatelessWidget {
  const ProductDetailsImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    final getHieght = mediaQuery.size.height;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Container(
          width: getWidht / 1.8,
          height: getHieght / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: whiteColor,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FirebaseImageProvider(
                FirebaseUrl(image),
                options: const CacheOptions(
                  checkForMetadataChange: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
