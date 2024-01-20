import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ProfileNameTypeWidget extends StatelessWidget {
  const ProfileNameTypeWidget({
    super.key,
    required this.name,
    required this.role,
  });
  final String name, role;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        Text(
          role,
          style: TextStyles.style13,
        ),
      ],
    );
  }
}
