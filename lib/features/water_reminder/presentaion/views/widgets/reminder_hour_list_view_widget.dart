import 'package:flutter/cupertino.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import '../../../../../core/utils/lists.dart';

class ReminderHourListViewWidget extends StatelessWidget {
  const ReminderHourListViewWidget({
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
      magnification: 0.75,
      squeeze: 2.2,
      useMagnifier: true,
      itemExtent: 80.0,
      onSelectedItemChanged: onSelectedItemChanged,
      children: list(context),
    );
  }
}

List<Widget> list(context) => List<Widget>.generate(
      times(context).length,
      (int index) {
        return Center(
          child: Text(
            times(context)[index],
            style: TextStyles.style17.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
