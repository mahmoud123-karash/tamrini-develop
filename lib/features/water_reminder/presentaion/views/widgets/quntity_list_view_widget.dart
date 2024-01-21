import 'package:flutter/cupertino.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class QuantityListViewWidget extends StatelessWidget {
  const QuantityListViewWidget({
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
      itemExtent: 80.0,
      onSelectedItemChanged: onSelectedItemChanged,
      children: grams(context),
    );
  }
}

List<Widget> grams(context) => List<Widget>.generate(
      1000,
      (int index) {
        return Center(
          child: Text(
            "$index ${S.of(context).ml}",
            style: TextStyles.style14.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
