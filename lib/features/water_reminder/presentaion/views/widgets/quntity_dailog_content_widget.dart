import 'package:flutter/cupertino.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../../core/utils/lists.dart';

class QuantityDialogContentWidget extends StatelessWidget {
  const QuantityDialogContentWidget({
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
      children: list(context),
    );
  }
}

List<Widget> list(context) => List<Widget>.generate(
      qunatities.length,
      (int index) {
        return Center(
          child: Text(
            "${qunatities[index]} ${S.of(context).ml}",
            style: TextStyles.style14.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
