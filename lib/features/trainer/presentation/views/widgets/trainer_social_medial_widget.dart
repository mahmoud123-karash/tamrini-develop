import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerSocialMediaWidget extends StatelessWidget {
  const TrainerSocialMediaWidget({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if (user.whatsApp == '') {
                showSnackBar(context, S.of(context).tranier_hint_social);
              } else {
                Uri uri = Uri(
                  scheme: 'sms',
                  path: user.whatsApp,
                );
                openUri(url: uri);
              }
            },
            child: const Icon(
              Ionicons.logo_whatsapp,
              color: Colors.greenAccent,
              size: 25,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (user.facebookUri == '') {
                showSnackBar(context, S.of(context).tranier_hint_social);
              } else {
                Uri uri = Uri.parse(user.facebookUri);
                openUri(url: uri);
              }
            },
            child: const Icon(
              Ionicons.logo_facebook,
              color: Colors.blue,
              size: 25,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (user.twiterUri == '') {
                showSnackBar(context, S.of(context).tranier_hint_social);
              } else {
                Uri uri = Uri.parse(user.twiterUri);
                openUri(url: uri);
              }
            },
            child: const Icon(
              Ionicons.logo_twitter,
              color: Colors.blue,
              size: 25,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (user.instgramUri == '') {
                showSnackBar(context, S.of(context).tranier_hint_social);
              } else {
                Uri uri = Uri.parse(user.instgramUri);
                openUri(url: uri);
              }
            },
            child: const Icon(
              Ionicons.logo_instagram,
              color: Colors.pink,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
