import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class CountryPickerWidget extends StatefulWidget {
  const CountryPickerWidget({super.key, this.color = Colors.white});
  final Color? color;

  @override
  State<CountryPickerWidget> createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  late String code;
  @override
  void initState() {
    code = CacheHelper.getData(key: 'code') ?? '+964';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          onTap: () {
            showCountryPicker(
              countryListTheme: CountryListThemeData(
                searchTextStyle: TextStyles.style14,
                textStyle: TextStyles.style14,
                inputDecoration: InputDecoration(
                  counterStyle: TextStyles.style14,
                  labelStyle: TextStyles.style14,
                  prefixIcon: const Icon(
                    Ionicons.search_outline,
                    color: Colors.black38,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: S.of(context).country,
                  hintStyle: TextStyles.style14,
                ),
              ),
              context: context,
              showPhoneCode: true,
              onSelect: (Country country) {
                code = "+${country.phoneCode}";
                saveCode("+${country.phoneCode}");
                log(country.phoneCode);
                setState(() {});
              },
            );
          },
          child: Text(
            code,
            style: TextStyles.style14.copyWith(
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}
