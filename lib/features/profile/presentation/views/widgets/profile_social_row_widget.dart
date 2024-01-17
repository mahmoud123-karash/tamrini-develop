import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

class ProfileSocialMediaWidget extends StatelessWidget {
  const ProfileSocialMediaWidget({
    super.key,
    required this.fUri,
    required this.nUri,
    required this.tUri,
    required this.phone,
    required this.isProfile,
  });
  final String fUri;
  final String nUri;
  final String tUri;
  final String phone;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isProfile ? 30 : 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Uri uri = Uri(
                scheme: 'sms',
                path: phone,
              );
              openUri(url: uri);
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
              if (fUri == '') {
                showSnackBar(
                  context,
                  isProfile
                      ? S.of(context).profile_hint_social
                      : S.of(context).tranier_hint_social,
                );
              } else {
                Uri uri = Uri.parse(fUri);
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
              if (tUri == '') {
                showSnackBar(
                  context,
                  isProfile
                      ? S.of(context).profile_hint_social
                      : S.of(context).tranier_hint_social,
                );
              } else {
                Uri uri = Uri.parse(tUri);
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
              if (nUri == '') {
                showSnackBar(
                  context,
                  isProfile
                      ? S.of(context).profile_hint_social
                      : S.of(context).tranier_hint_social,
                );
              } else {
                Uri uri = Uri.parse(nUri);
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
