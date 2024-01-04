import 'package:tamrini/core/shared/assets.dart';
import 'package:flutter/material.dart';

class DriverImageCirclarAvatarWidget extends StatelessWidget {
  const DriverImageCirclarAvatarWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CircleAvatar(
        backgroundImage: image == ''
            ? const AssetImage(Assets.imagesProfile) as ImageProvider
            : NetworkImage(image),
      ),
    );
  }
}
