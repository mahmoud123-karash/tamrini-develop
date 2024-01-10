import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class QuestionTimeAndDateWidget extends StatelessWidget {
  const QuestionTimeAndDateWidget(
      {super.key, required this.date, required this.time});
  final String date, time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          time,
          style: const TextStyle(
            color: Color(0xFF687684),
            fontSize: 15,
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: -0.30,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Text(
          date,
          style: const TextStyle(
            color: Color(0xFF687684),
            fontSize: 15,
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: -0.30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Tamrini",
          style: TextStyle(
            color: appColor,
            fontSize: 15,
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: -0.30,
          ),
        ),
      ],
    );
  }
}
