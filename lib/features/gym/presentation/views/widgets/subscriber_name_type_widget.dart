import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class SubscriberNameTypeWidget extends StatelessWidget {
  const SubscriberNameTypeWidget({
    super.key,
    required this.name,
    required this.type,
  });
  final String name, type;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          type,
          style: TextStyles.style14,
        )
      ],
    );
  }
}
