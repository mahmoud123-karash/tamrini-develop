import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class PublisherNameAndRoleWidget extends StatelessWidget {
  const PublisherNameAndRoleWidget(
      {super.key, required this.role, required this.name});
  final String role, name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyles.style17.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          role,
          style: TextStyles.style13.copyWith(),
        ),
      ],
    );
  }
}
