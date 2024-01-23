import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import '../../../../../core/utils/lists.dart';
import 'auto_reminder_close_done_widget.dart';

class AutoReminderDialogContentWidget extends StatelessWidget {
  const AutoReminderDialogContentWidget({
    required this.onPressed,
    super.key,
    required this.onSelectedItemChanged,
    required this.scrollController,
  });
  final Function(int) onSelectedItemChanged;
  final FixedExtentScrollController scrollController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        AutoReminderCloseDoneWidget(onPressed: onPressed),
        Container(
          width: double.infinity,
          height: 300.sp,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoPicker(
              scrollController: scrollController,
              magnification: 0.75,
              squeeze: 2.2,
              useMagnifier: true,
              itemExtent: 80.0,
              onSelectedItemChanged: onSelectedItemChanged,
              children: list(context),
            ),
          ),
        ),
      ],
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
