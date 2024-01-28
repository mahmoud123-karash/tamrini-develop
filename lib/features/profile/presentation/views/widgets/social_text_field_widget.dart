import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/country_picker_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SocialTextFiledWidget extends StatelessWidget {
  const SocialTextFiledWidget({
    super.key,
    required this.controller,
    required this.autovalidateMode,
    required this.prefix,
  });
  final TextEditingController controller;
  final AutovalidateMode autovalidateMode;
  final String prefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greyColor.withOpacity(0.2),
      ),
      child: TextFormField(
        minLines: 1,
        maxLines: 2,
        autovalidateMode: autovalidateMode,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return null;
          } else {
            if (!value.contains(prefix)) {
              return 'Invalid URI';
            }
            return null;
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        keyboardType: TextInputType.url,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          hintText: prefix == ''
              ? S.of(context).enter_phone
              : S.of(context).enter_uri,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffix: prefix == ''
              ? CountryPickerWidget(
                  color: appColor,
                )
              : null,
        ),
      ),
    );
  }
}
