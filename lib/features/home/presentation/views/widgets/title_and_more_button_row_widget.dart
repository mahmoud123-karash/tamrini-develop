import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/generated/l10n.dart';

class TitleAndMoreButtonRowWidget extends StatelessWidget {
  const TitleAndMoreButtonRowWidget(
      {super.key, required this.lable, required this.onPressed});
  final String lable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: Intl.getCurrentLocale() == 'en' ? 20 : 5,
        right: Intl.getCurrentLocale() == 'ar' ? 20 : 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lable,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              S.of(context).more,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
