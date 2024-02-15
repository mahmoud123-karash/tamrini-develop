import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class PublisherNameAndRoleWidget extends StatelessWidget {
  const PublisherNameAndRoleWidget(
      {super.key, required this.role, required this.name});
  final String role, name;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width / 2),
          child: Text(
            name,
            style: TextStyles.style17.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
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
