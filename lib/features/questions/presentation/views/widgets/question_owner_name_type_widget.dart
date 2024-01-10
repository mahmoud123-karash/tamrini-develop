import 'package:flutter/material.dart';

class QuestionOwnerNameTypeWidgt extends StatelessWidget {
  const QuestionOwnerNameTypeWidgt(
      {super.key, required this.name, required this.role});
  final String name, role;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$name\n',
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w600,
              height: 0,
              letterSpacing: -0.30,
            ),
          ),
          TextSpan(
            text: role,
            style: const TextStyle(
              color: Color(0xFF687684),
              fontSize: 15,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: -0.30,
            ),
          ),
        ],
      ),
    );
  }
}
