import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/water_reminder/presentaion/views/widgets/reminder_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'quntity_list_view_widget.dart';

class AddReminderBottomSheetWidget extends StatefulWidget {
  const AddReminderBottomSheetWidget({super.key});

  @override
  State<AddReminderBottomSheetWidget> createState() =>
      _AddReminderBottomSheetWidgetState();
}

class _AddReminderBottomSheetWidgetState
    extends State<AddReminderBottomSheetWidget> {
  TextEditingController timeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  FixedExtentScrollController? controller;

  @override
  void initState() {
    controller = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    timeController.dispose();
    quantityController.dispose();
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  S.of(context).add_reminder,
                  style: TextStyles.style17.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ReminderTextFieldWidgt(
                  onTap: () async {
                    final TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      if (newTime != null) {
                        timeController.text = newTime.format(context);
                      }
                    });
                  },
                  autovalidateMode: autovalidateMode,
                  controller: timeController,
                  lable: S.of(context).time,
                  icon: Icons.timelapse,
                ),
                const SizedBox(
                  height: 20,
                ),
                ReminderTextFieldWidgt(
                  onTap: () {
                    showQuantityDialog(
                      child: QuantityListViewWidget(
                        onSelectedItemChanged: (selectedItem) {
                          quantityController.text =
                              '$selectedItem ${S.of(context).ml}';
                          setState(() {});
                        },
                        scrollController: controller!,
                      ),
                      controller: controller!,
                      context: context,
                      selectedQuantity: 300,
                    );
                  },
                  autovalidateMode: autovalidateMode,
                  controller: quantityController,
                  lable: S.of(context).quantity,
                  icon: Icons.question_mark_outlined,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: appColor,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      S.of(context).submit,
                      style: TextStyles.style14.copyWith(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
