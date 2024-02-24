import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class RequestInfoRowWidget extends StatelessWidget {
  const RequestInfoRowWidget({
    super.key,
    required this.value,
    required this.lable,
  });
  final String value, lable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          Text(
            lable,
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyles.style14.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
