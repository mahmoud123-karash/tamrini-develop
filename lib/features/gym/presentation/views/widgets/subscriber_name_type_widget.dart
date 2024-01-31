import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class SubscriberNameTypeWidget extends StatelessWidget {
  const SubscriberNameTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mahmoud ahmed',
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'user',
          style: TextStyles.style14,
        )
      ],
    );
  }
}
