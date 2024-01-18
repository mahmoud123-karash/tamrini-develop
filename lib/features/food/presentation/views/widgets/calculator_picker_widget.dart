import 'package:flutter/cupertino.dart';

class CalculatorPickerWidget extends StatelessWidget {
  const CalculatorPickerWidget({
    super.key,
    required this.scrollController,
    required this.onSelectedItemChanged,
    required this.list,
  });
  final FixedExtentScrollController scrollController;
  final Function(int) onSelectedItemChanged;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: scrollController,
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: false,
      itemExtent: 50.0,
      onSelectedItemChanged: onSelectedItemChanged,
      children: List<Widget>.generate(
        list.length,
        (int index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                list[index],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
