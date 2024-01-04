import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class SendTextFieldWidget extends StatefulWidget {
  const SendTextFieldWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<SendTextFieldWidget> createState() => _SendTextFieldWidgetState();
}

class _SendTextFieldWidgetState extends State<SendTextFieldWidget> {
  int lines = 1;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: greyColor.withOpacity(0.3),
        ),
        child: TextFormField(
          maxLines: lines,
          onChanged: (value) {
            if (value.length > 30) {
              lines = 2;
            } else {
              lines = 1;
            }
            setState(() {});
          },
          controller: widget.controller,
          style: TextStyles.style16Bold.copyWith(
            fontFamily: '',
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            hintText: 'Type a message',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
