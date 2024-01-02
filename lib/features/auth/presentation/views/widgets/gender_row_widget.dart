import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';

class GenderRowWidget extends StatefulWidget {
  const GenderRowWidget({super.key});

  @override
  State<GenderRowWidget> createState() => _GenderRowWidgetState();
}

class _GenderRowWidgetState extends State<GenderRowWidget> {
  String gender = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 20,
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: whiteColor,
                    ),
                  ),
                ),
                child: Radio(
                  activeColor: appColor,
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    saveGender(value);
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                S.of(context).male,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                width: 20,
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: whiteColor,
                    ),
                  ),
                ),
                child: Radio(
                  activeColor: appColor,
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    saveGender(value);
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                S.of(context).female,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
