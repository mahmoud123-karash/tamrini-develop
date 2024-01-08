import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerSocialMediaWidget extends StatelessWidget {
  const TrainerSocialMediaWidget({super.key, required this.contacts});
  final List<String> contacts;

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
              List<String> list =
                  contacts.where((element) => element.contains('+')).toList();
              if (list.isEmpty) {
                showSnackBar(context, S.of(context).tranier_hint_social);
              } else {
                Uri uri = Uri(
                  scheme: 'sms',
                  path: list.first,
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
              List<String> list = contacts
                  .where((element) => element.contains('facebook.com'))
                  .toList();
              if (list.isEmpty) {
                showSnackBar(context, S.of(context).tranier_hint_social);
              } else {
                Uri uri = Uri.parse(list.first);
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
              List<String> list = contacts
                  .where((element) => element.contains('twitter.com'))
                  .toList();
              if (list.isEmpty) {
                showSnackBar(context, S.of(context).tranier_hint_social);
              } else {
                Uri uri = Uri.parse(list.first);
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
              List<String> list = contacts
                  .where((element) => element.contains('instagram.com'))
                  .toList();
              if (list.isEmpty) {
                showSnackBar(context, S.of(context).tranier_hint_social);
              } else {
                Uri uri = Uri.parse(list.first);
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
