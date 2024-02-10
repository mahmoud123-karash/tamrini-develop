import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class PromotionUserImageNameWidget extends StatelessWidget {
  const PromotionUserImageNameWidget({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (user.role == 'admin') {
              showSnackBar(context, S.of(context).admin_hint);
            } else {
              if (user.role == 'captain') {
                navigateTo(
                  context,
                  TrainerProfileScreen(
                    trainer:
                        TrainersCubit.get(context).getTrainer(uid: user.uid),
                  ),
                );
              } else {
                navigateTo(context, UserProfileScreen(model: user));
              }
            }
          },
          child: CircleAvatar(
            radius: 35,
            backgroundImage: user.image != ''
                ? FirebaseImageProvider(
                    FirebaseUrl(user.image),
                  )
                : const AssetImage(Assets.imagesProfile) as ImageProvider,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          user.name,
          style: TextStyles.style16Bold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
