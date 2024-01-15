import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ValueIconRowWidget extends StatelessWidget {
  const ValueIconRowWidget(
      {super.key, required this.value, required this.icon});
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: appColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            value,
            style: TextStyles.style14,
          )
        ],
      ),
    );
  }
}
