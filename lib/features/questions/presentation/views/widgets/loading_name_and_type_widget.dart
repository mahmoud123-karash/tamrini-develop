import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class LoadingNamwANdTypeWidget extends StatelessWidget {
  const LoadingNamwANdTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: appColor.withOpacity(0.3),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: appColor.withOpacity(0.3),
              height: 20,
              width: 150,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: appColor.withOpacity(0.3),
              height: 20,
              width: 100,
            )
          ],
        ),
      ],
    );
  }
}
