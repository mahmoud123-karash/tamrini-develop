import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ProfileNameTypeWidget extends StatelessWidget {
  const ProfileNameTypeWidget({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    String type = CacheHelper.getData(key: 'usertype') ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        Text(
          type,
          style: TextStyles.style13,
        ),
      ],
    );
  }
}
