import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/generated/l10n.dart';

class AgreePrivacyRowWidget extends StatefulWidget {
  const AgreePrivacyRowWidget({super.key});

  @override
  State<AgreePrivacyRowWidget> createState() => _AgreePrivacyRowWidgetState();
}

class _AgreePrivacyRowWidgetState extends State<AgreePrivacyRowWidget> {
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(color: whiteColor, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Checkbox(
              activeColor: appColor,
              value: agree,
              onChanged: (bool? value) {
                savePrivacy(value);
                setState(() {
                  agree = value!;
                });
              },
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Text(
            S.of(context).agree,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              openUri(
                uri: Uri.parse(privacyUri),
              );
            },
            child: Text(
              S.of(context).privacy,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: appColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
