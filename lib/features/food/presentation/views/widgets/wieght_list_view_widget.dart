import 'package:flutter/cupertino.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class WeightListViewWidget extends StatelessWidget {
  const WeightListViewWidget({
    super.key,
    required this.onSelectedItemChanged,
    required this.scrollController,
  });
  final Function(int) onSelectedItemChanged;
  final FixedExtentScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: scrollController,
      magnification: 1.22,
      squeeze: 2.2,
      useMagnifier: true,
      itemExtent: 50.0,
      onSelectedItemChanged: onSelectedItemChanged,
      children: grams,
    );
  }
}

List<Widget> grams = List<Widget>.generate(
  1000,
  (int index) {
    return Center(
      child: Text(
        index.toString(),
        style: TextStyles.style14.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  },
);
