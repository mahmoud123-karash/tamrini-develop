import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/views/reset_password_screen.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/settings/presentation/views/language_screen.dart';
import 'package:tamrini/features/settings/presentation/views/widgets/settings_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/them_list_tile_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).settings),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SettingsListTileWidget(
              onPressed: () {
                navigateTo(context, const ProfileScreen());
              },
              iconData: Ionicons.person,
              lable: S.of(context).profile,
            ),
            const Divider(),
            SettingsListTileWidget(
              onPressed: () {
                navigateTo(context, const ResetPassScreen());
              },
              iconData: Ionicons.lock_closed,
              lable: S.of(context).change_pass,
            ),
            const Divider(),
            const ThemeListTileWidget(),
            const Divider(),
            SettingsListTileWidget(
              onPressed: () {
                navigateTo(context, const LanguageScreen());
              },
              iconData: Icons.language,
              lable: S.of(context).language,
            ),
            const Divider(),
            SettingsListTileWidget(
              onPressed: () {
                logOutDialog(context).show();
              },
              iconData: Ionicons.log_out_outline,
              lable: S.of(context).log_out,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
