import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/views/reset_password_screen.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/presentation/views/edit_profile_screen.dart';
import 'package:tamrini/features/settings/presentation/views/settings_screen.dart';
import 'package:tamrini/features/promotion/presentation/views/upgrade_account_screen.dart';
import 'package:tamrini/generated/l10n.dart';
import 'profile_content_sliver_box_widget.dart';
import 'profile_list_tile_widget.dart';

class ProfileContentWidget extends StatelessWidget {
  const ProfileContentWidget({super.key, required this.model});
  final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ProfileContentSliverBoxWidget(model: model),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
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
                  onPressed: () {
                    navigateTo(context, const SettingsScreen());
                  },
                  lable: S.of(context).settings,
                  icon: Ionicons.settings_outline,
                ),
                if (CacheHelper.getData(key: 'usertype') == 'user')
                  ProfileListTileWidget(
                    onPressed: () {
                      navigateTo(context, const UpgradeAcountScreen());
                    },
                    lable: S.of(context).update_your_account,
                    icon: Icons.stars,
                  ),
                ProfileListTileWidget(
                  onPressed: () {
                    logOutDialog(context).show();
                  },
                  lable: S.of(context).log_out,
                  icon: Icons.logout,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
