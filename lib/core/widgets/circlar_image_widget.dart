import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';

class CirclarImageWidget extends StatelessWidget {
  const CirclarImageWidget({
    super.key,
    required this.image,
    required this.radius,
  });
  final String image;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image(
        height: radius * 2,
        width: radius * 2,
        image: image == ""
            ? const AssetImage(Assets.imagesProfile) as ImageProvider
            : FirebaseImageProvider(
                FirebaseUrl(image),
                options: const CacheOptions(
                  source: Source.cacheServer,
                ),
              ),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage(Assets.imagesProfile),
          );
        },
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (frame != null) return child;
          return CircleAvatar(
            radius: radius,
          );
        },
      ),
    );
  }
}
