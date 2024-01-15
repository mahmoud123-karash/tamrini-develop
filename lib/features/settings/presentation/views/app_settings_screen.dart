import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/settings/presentation/views/about_app_screen.dart';
import 'package:tamrini/features/settings/presentation/views/app_instructions_screen.dart';
import 'package:tamrini/features/settings/presentation/views/widgets/settings_list_tile_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).app),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SettingsListTileWidget(
              iconData: Ionicons.information_circle_sharp,
              lable: S.of(context).about_app,
              onPressed: () {
                navigateTo(context, const AboutAppScreen());
              },
            ),
            const Divider(),
            SettingsListTileWidget(
              iconData: Ionicons.information_sharp,
              lable: S.of(context).how_to_use_app,
              onPressed: () {
                navigateTo(context, const AppInstructionScreen());
              },
            ),
            const Divider(),
            SettingsListTileWidget(
              iconData: Ionicons.share_social_outline,
              lable: S.of(context).share_app,
              onPressed: () {
                share(
                  title: 'Tamrini App',
                  text: 'كل ما يخص عالم كمال الإجسام ستجده هنا',
                );
              },
            ),
            const Divider(),
            SettingsListTileWidget(
              iconData: Ionicons.star,
              lable: S.of(context).rate_app,
              onPressed: () {
                Uri appUri = Uri.parse(appLink);
                openUri(url: appUri);
              },
            ),
            const Divider(),
            SettingsListTileWidget(
              iconData: Icons.privacy_tip,
              lable: S.of(context).privacy,
              onPressed: () {
                Uri uri = Uri.parse(privacyUri);
                openUri(url: uri);
              },
            )
          ],
        ),
      ),
    );
  }
}
