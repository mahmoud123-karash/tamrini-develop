import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_cubit.dart';
import 'calculator_floating_button_widget.dart';

class WieghtContainerWidget extends StatefulWidget {
  const WieghtContainerWidget({
    super.key,
    required this.lable,
    required this.number,
    required this.isAge,
  });
  final String lable;
  final int number;
  final bool isAge;

  @override
  State<WieghtContainerWidget> createState() => _WieghtContainerWidgetState();
}

class _WieghtContainerWidgetState extends State<WieghtContainerWidget> {
  late int num;
  @override
  void initState() {
    num = widget.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150.sp,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: appColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.lable,
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            Text(
              num.toString(),
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyFlooatingButton(
                  myIcon: Icons.remove,
                  onPressed: () {
                    num--;
                    if (widget.isAge) {
                      CalculatorCubit.get(context).age = num;
                    } else {
                      CalculatorCubit.get(context).wight = num;
                    }
                    log(num.toString());
                    CalculatorCubit.get(context).calculate();
                    setState(() {});
                  },
                ),
                MyFlooatingButton(
                  myIcon: Icons.add,
                  onPressed: () {
                    num++;
                    if (widget.isAge) {
                      CalculatorCubit.get(context).age = num;
                    } else {
                      CalculatorCubit.get(context).wight = num;
                    }
                    CalculatorCubit.get(context).calculate();
                    setState(() {});
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
