import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    super.key,
    required this.message,
    required this.isSender,
    required this.time,
  });
  final String message;
  final DateTime time;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return Row(
      mainAxisAlignment: isSender
          ? Intl.getCurrentLocale() == 'ar'
              ? MainAxisAlignment.start
              : MainAxisAlignment.end
          : Intl.getCurrentLocale() == 'ar'
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: getWidht - 95,
          ),
          decoration: ShapeDecoration(
            color: isSender
                ? appColor.withOpacity(0.3)
                : greyColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isSender ? 20 : 0),
                bottomRight: Radius.circular(!isSender ? 20 : 0),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: TextStyles.style14.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: message.contains(RegExp(r'[A-Z]'))
                      ? TextAlign.left
                      : TextAlign.right,
                ),
                Text(
                  DateFormat('h:m a').format(time),
                  style: TextStyles.style12.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
