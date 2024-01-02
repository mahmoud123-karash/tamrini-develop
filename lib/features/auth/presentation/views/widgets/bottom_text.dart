import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class BottomText extends StatefulWidget {
  const BottomText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.onPressed});
  final String text1;
  final String text2;
  final VoidCallback onPressed;

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {},
      onTap: widget.onPressed,
      behavior: HitTestBehavior.opaque,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Montserrat',
          ),
          children: [
            TextSpan(
              text: widget.text1,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: widget.text2,
              style: TextStyle(
                color: appColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
