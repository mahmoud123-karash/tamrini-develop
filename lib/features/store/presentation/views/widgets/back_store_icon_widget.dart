import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:intl/intl.dart';

class BackStoreIconWidget extends StatelessWidget {
  const BackStoreIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String curretLang = Intl.getCurrentLocale().split('_')[0];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: appColor.withOpacity(0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              curretLang == 'ar'
                  ? Icons.arrow_back_ios_new_sharp
                  : Icons.arrow_forward_ios_outlined,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
