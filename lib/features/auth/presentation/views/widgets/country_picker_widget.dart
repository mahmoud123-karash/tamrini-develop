import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class CountryPickerWidget extends StatefulWidget {
  const CountryPickerWidget({super.key});

  @override
  State<CountryPickerWidget> createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  String code = '964';
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
                code = country.phoneCode;
                setState(() {});
              },
            );
          },
          child: Text(
            '+$code',
            style: TextStyles.style14.copyWith(
              color: whiteColor,
            ),
          ),
        );
      },
    );
  }
}
