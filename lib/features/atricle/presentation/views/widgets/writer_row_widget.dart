import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'publisher_name_and_role_widget.dart';

class WriterRowWidget extends StatelessWidget {
  const WriterRowWidget({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return model.isBanned
        ? Container()
        : Row(
            children: [
              GestureDetector(
                onTap: () {
                  String uid = CacheHelper.getData(key: 'uid') ?? '';
                  if (model.uid == uid) {
                    navigateTo(context, const ProfileScreen());
                  } else if (model.role == 'admin') {
                    showSnackBar(context, S.of(context).admin_hint);
                  } else {
                    navigateTo(context, UserProfileScreen(model: model));
                  }
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: model.image != ''
                      ? FirebaseImageProvider(
                          FirebaseUrl(model.image),
                        ) as ImageProvider
                      : const AssetImage(Assets.imagesProfile),
                ),
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
