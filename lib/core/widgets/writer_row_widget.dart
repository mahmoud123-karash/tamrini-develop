import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../features/trainer/presentation/views/trainer_profile_screen.dart';
import '../../features/atricle/presentation/views/widgets/publisher_name_and_role_widget.dart';

class WriterRowWidget extends StatelessWidget {
  const WriterRowWidget({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            String uid = CacheHelper.getData(key: 'uid') ?? '';
            if (model.uid == uid) {
              navigateTo(context, const ProfileScreen());
            } else if (model.role == UserType.admin) {
              showSnackBar(context, S.of(context).admin_hint);
            } else if (model.role == UserType.trainer) {
              navigateTo(context, TrainerProfileScreen(id: model.uid));
            } else {
              navigateTo(context, UserProfileScreen(model: model));
            }
          },
          child: CirclarImageWidget(
            radius: 40,
            image: model.image,
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
        if (model.role == UserType.admin)
          const Icon(
            Icons.stars_rounded,
            color: Colors.amber,
          )
      ],
    );
  }
}
