import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';

class TarinerImageWidget extends StatelessWidget {
  const TarinerImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    return SizedBox(
      width: getWidht,
      height: getHeight * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image(
          image: image != ''
              ? FirebaseImageProvider(
                  FirebaseUrl(image),
                )
              : const AssetImage(Assets.imagesProfile) as ImageProvider,
          fit: BoxFit.cover,
          width: getWidht * 0.7 - 20,
          height: getHeight * 0.3,
        ),
      ),
    );
  }
}
