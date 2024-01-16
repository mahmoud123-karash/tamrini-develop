import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/presentation/views/social_media_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class SocialMediaProfileRowWidget extends StatelessWidget {
  const SocialMediaProfileRowWidget({super.key, required this.model});
  final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Row(
        children: [
          Text(
            S.of(context).media,
            style: TextStyles.style16Bold.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              navigateTo(context, SocilaMediaScreen(model: model));
            },
            icon: Icon(
              Icons.edit_outlined,
              color: appColor,
            ),
          )
        ],
      ),
    );
  }
}
