import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class NameAswertypeUserLoadingWidget extends StatelessWidget {
  const NameAswertypeUserLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: appColor.withOpacity(0.3),
              height: 15,
              width: width / 3,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: appColor.withOpacity(0.3),
              height: 10,
              width: width / 4,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          color: appColor.withOpacity(0.3),
          height: 15,
          width: width - (60 + 40 + 30),
          child: const Text(
            '',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w300,
              letterSpacing: -0.90,
            ),
            textAlign: TextAlign.start,
            maxLines: 5,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          color: appColor.withOpacity(0.3),
          height: 10,
          width: width / 2,
        ),
      ],
    );
  }
}
