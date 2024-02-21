import 'package:flutter/material.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';

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
          CirclarImageWidget(
            radius: 50,
            image: image,
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
