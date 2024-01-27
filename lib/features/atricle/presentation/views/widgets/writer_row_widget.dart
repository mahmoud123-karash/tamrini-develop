import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';

import 'publisher_name_and_role_widget.dart';

class WriterRowWidget extends StatelessWidget {
  const WriterRowWidget({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: model.image != ''
              ? FirebaseImageProvider(
                  FirebaseUrl(model.image),
                ) as ImageProvider
              : const AssetImage(Assets.imagesProfile),
        ),
        const SizedBox(
          width: 10,
        ),
        PublisherNameAndRoleWidget(
          role: model.role,
          name: model.name,
        ),
        const Spacer(),
        if (model.role == 'admin')
          const Icon(
            Icons.stars_rounded,
            color: Colors.amber,
          )
      ],
    );
  }
}
