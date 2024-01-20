import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';

import 'profile_name_type_widget.dart';

class ProfileImageNameTypeWidget extends StatelessWidget {
  const ProfileImageNameTypeWidget({
    super.key,
    required this.name,
    required this.image,
    required this.role,
  });
  final String name, image, role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: image == ''
                ? const AssetImage(
                    Assets.imagesProfile,
                  )
                : FirebaseImageProvider(FirebaseUrl(image)) as ImageProvider,
          ),
          const SizedBox(
            width: 10,
          ),
          ProfileNameTypeWidget(
            name: name,
            role: role,
          ),
        ],
      ),
    );
  }
}
