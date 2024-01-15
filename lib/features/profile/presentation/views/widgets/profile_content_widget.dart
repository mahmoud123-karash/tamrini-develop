import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/auth/presentation/views/reset_password_screen.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/presentation/views/edit_profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'profile_image_name_type_widget.dart';
import 'profile_list_tile_widget.dart';
import 'value_icon_row_widget.dart';

class ProfileContentWidget extends StatelessWidget {
  const ProfileContentWidget({super.key, required this.model});
  final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          height: 20,
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
        const SizedBox(
          height: 10,
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: appColor.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              ProfileListTileWidget(
                onPressed: () {
                  navigateTo(context, EditProfileScreen(model: model));
                },
                lable: S.of(context).edit_profile,
                icon: Icons.edit_outlined,
              ),
              ProfileListTileWidget(
                onPressed: () {
                  navigateTo(context, const ResetPassScreen());
                },
                lable: S.of(context).change_pass,
                icon: Icons.lock_outline,
              ),
              ProfileListTileWidget(
                onPressed: () {},
                lable: S.of(context).settings,
                icon: Icons.settings_applications_outlined,
              ),
              if (CacheHelper.getData(key: 'usertype') == 'User')
                ProfileListTileWidget(
                  onPressed: () {},
                  lable: S.of(context).update_your_account,
                  icon: Icons.stars,
                ),
              ProfileListTileWidget(
                onPressed: () {},
                lable: S.of(context).log_out,
                icon: Icons.logout,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
