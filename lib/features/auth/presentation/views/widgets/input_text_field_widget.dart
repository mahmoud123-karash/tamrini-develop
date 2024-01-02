import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';

import 'package:tamrini/generated/l10n.dart';

import 'country_picker_widget.dart';

class InputTextFielsWidget extends StatefulWidget {
  const InputTextFielsWidget({
    super.key,
    required this.hint,
    required this.iconData,
    required this.controller,
    required this.type,
    required this.autovalidateMode,
  });
  final String hint;
  final IconData iconData;
  final TextEditingController controller;
  final TextInputType type;
  final AutovalidateMode autovalidateMode;

  @override
  State<InputTextFielsWidget> createState() => _InputTextFielsWidgetState();
}

class _InputTextFielsWidgetState extends State<InputTextFielsWidget> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.sp, vertical: 8.sp),
      child: SizedBox(
        height: 50,
        width: 250.w,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return S.of(context).validate;
            }
            return null;
          },
          autovalidateMode: widget.autovalidateMode,
          maxLines: 1,
          enableInteractiveSelection: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'cairo',
          ),
          controller: widget.controller,
          textAlignVertical: TextAlignVertical.bottom,
          keyboardType: widget.type,
          obscureText: widget.iconData == Ionicons.lock_closed_outline
              ? isSecure
              : false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            hintMaxLines: 1,
            helperMaxLines: 1,
            errorMaxLines: 1,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            prefixIcon: Icon(widget.iconData, color: Colors.white),
            suffix: widget.iconData == Ionicons.call_outline
                ? const CountryPickerWidget()
                : widget.iconData == Ionicons.lock_closed_outline
                    ? IconButton(
                        onPressed: () {
                          isSecure = !isSecure;
                          setState(() {});
                        },
                        icon: Icon(
                          !isSecure ? Icons.visibility_off : Icons.visibility,
                          color: whiteColor,
                        ),
                      )
                    : null,
          ),
        ),
      ),
    );
  }
}
