import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';

class ProfileContentWidget extends StatelessWidget {
  const ProfileContentWidget({super.key, required this.model});
  final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: model.image == ''
              ? const AssetImage(
                  Assets.imagesProfile,
                )
              : FirebaseImageProvider(FirebaseUrl(model.image))
                  as ImageProvider,
        ),
        IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.delete),
        )
      ],
    );
  }
}
