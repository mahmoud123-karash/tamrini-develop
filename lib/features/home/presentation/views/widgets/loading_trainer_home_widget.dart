import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class HomeTrainerLoadingWidget extends StatelessWidget {
  const HomeTrainerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 30,
        ),
        const SizedBox(
          height: 7,
        ),
        Container(
          color: appColor,
          width: 40,
          height: 8,
        )
      ],
    );
  }
}
