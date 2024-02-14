import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class SendTextFieldWidget extends StatefulWidget {
  const SendTextFieldWidget(
      {super.key, required this.controller, required this.onChange});
  final TextEditingController controller;
  final VoidCallback onChange;

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
            widget.onChange();
            setState(() {});
          },
          controller: widget.controller,
          style: TextStyles.style13.copyWith(
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            hintText: S.of(context).type_a_message,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
