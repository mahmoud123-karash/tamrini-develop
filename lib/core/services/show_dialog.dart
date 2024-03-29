import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: Center(
      child: Image.asset(Assets.imagesLoading),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showPickerDialog({
  required Widget child,
  required FixedExtentScrollController controller,
  required int selectedMeal,
  required Widget textField,
  required BuildContext context,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback(
          (context) => controller.jumpToItem(selectedMeal));
      return ListView(
        shrinkWrap: true,
        children: [
          Material(
            child: SizedBox(
              height: 70.h,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      S.of(context).ok,
                      style: TextStyles.style15.copyWith(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: textField,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 300.h,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: child,
            ),
          ),
        ],
      );
    },
  );
}

void showWeightDialog({
  required Widget child,
  required FixedExtentScrollController controller,
  required BuildContext context,
  required int selectedWeight,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback(
        (context) => controller.jumpToItem(
          selectedWeight,
        ),
      );
      return ListView(
        shrinkWrap: true,
        children: [
          Material(
            child: SizedBox(
              height: 70.h,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      S.of(context).ok,
                      style: TextStyles.style15.copyWith(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        S.of(context).select_meal_wieght,
                        style: TextStyles.style15.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
              child: child,
            ),
          ),
        ],
      );
    },
  );
}

void showCalculatorDialog({
  required Widget child,
  required FixedExtentScrollController controller,
  required int selectedPurpose,
  required BuildContext context,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback(
        (context) => controller.jumpToItem(
          selectedPurpose,
        ),
      );

      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    S.of(context).ok,
                    style: TextStyles.style15.copyWith(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            height: 250.sp,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: child,
            ),
          ),
        ],
      );
    },
  );
}

void showReminderDialog({
  required Widget child,
  required FixedExtentScrollController controller,
  required BuildContext context,
  required int selectedItem,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback(
        (context) => controller.jumpToItem(
          selectedItem,
        ),
      );

      return child;
    },
  );
}
