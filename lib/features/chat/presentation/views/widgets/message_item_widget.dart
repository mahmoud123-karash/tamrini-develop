import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    super.key,
    required this.message,
    required this.isSender,
  });
  final String message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: getWidht - 95,
          ),
          decoration: ShapeDecoration(
            color: isSender ? appColor.withOpacity(0.3) : whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isSender ? 20 : 0),
                bottomRight: Radius.circular(!isSender ? 20 : 0),
              ),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Text(
              message,
              style: TextStyles.style17,
              textAlign: message.contains(RegExp(r'[A-Z]'))
                  ? TextAlign.left
                  : TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
