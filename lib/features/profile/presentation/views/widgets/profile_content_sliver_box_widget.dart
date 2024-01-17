import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_image_name_type_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_location_builder_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_social_row_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/social_media_profile_row_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/value_icon_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ProfileContentSliverBoxWidget extends StatelessWidget {
  const ProfileContentSliverBoxWidget({super.key, required this.model});
  final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        ProfileImageNameTypeWidget(name: model.name, image: model.image),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            S.of(context).account_details,
            style: TextStyles.style19.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ValueIconRowWidget(
          value: model.email,
          icon: Icons.email_outlined,
        ),
        ValueIconRowWidget(
          value: model.phone,
          icon: Icons.phone_android,
        ),
        const ProfileLocationBuilderWidget(),
        SocialMediaProfileRowWidget(model: model),
        const SizedBox(
          height: 10,
        ),
        ProfileSocialMediaWidget(
          fUri: model.facebookUri,
          nUri: model.instgramUri,
          tUri: model.twiterUri,
          phone: model.phone,
          isProfile: true,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
