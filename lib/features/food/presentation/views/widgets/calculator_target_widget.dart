import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/features/food/presentation/views/widgets/calculator_picker_widget.dart';

class CalculatorTargetWidget extends StatelessWidget {
  const CalculatorTargetWidget({
    super.key,
    required this.controller,
    required this.selectedItem,
    required this.onSelectedItemChanged,
    required this.list,
    required this.selctedItem,
  });
  final FixedExtentScrollController controller;
  final String selectedItem;
  final Function(int) onSelectedItemChanged;
  final List<String> list;
  final int selctedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 200.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: appColor,
            ),
            child: CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                showCalculatorDialog(
                  child: CalculatorPickerWidget(
                    scrollController: controller,
                    onSelectedItemChanged: onSelectedItemChanged,
                    list: list,
                  ),
                  controller: controller,
                  selectedPurpose: selctedItem,
                  context: context,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        left: 10,
                      ),
                      child: Text(
                        selectedItem,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
