import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class MealNameIconRowWidget extends StatelessWidget {
  const MealNameIconRowWidget({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width / 2),
          child: Text(
            name,
            style: TextStyles.style16Bold.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Ionicons.heart, color: Colors.red),
        )
      ],
    );
  }
}
