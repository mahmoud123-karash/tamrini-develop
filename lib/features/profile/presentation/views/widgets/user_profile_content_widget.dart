import 'package:flutter/material.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/name_text_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_image_name_type_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_social_row_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/value_icon_row_widget.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';
import 'package:tamrini/generated/l10n.dart';

class UserProfileContentWidget extends StatelessWidget {
  const UserProfileContentWidget({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 20,
          ),
          child: ProfileImageNameTypeWidget(
            name: model.name,
            image: model.image,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: NameTextWidget(text: S.of(context).location),
        ),
        const SizedBox(
          height: 5,
        ),
        ValueIconRowWidget(
          value: model.address,
          icon: Icons.location_on_outlined,
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: NameTextWidget(text: S.of(context).media),
        ),
        const SizedBox(
          height: 20,
        ),
        ProfileSocialMediaWidget(
          fUri: model.facebookUri,
          nUri: model.instgramUri,
          tUri: model.twiterUri,
          phone: model.phone,
          isProfile: false,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
