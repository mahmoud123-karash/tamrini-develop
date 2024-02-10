import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class EndedSubedRowWidget extends StatelessWidget {
  const EndedSubedRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: appColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            S.of(context).subed,
            style: TextStyles.style16Bold.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.circle,
            color: Colors.red,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            S.of(context).ended,
            style: TextStyles.style16Bold.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
