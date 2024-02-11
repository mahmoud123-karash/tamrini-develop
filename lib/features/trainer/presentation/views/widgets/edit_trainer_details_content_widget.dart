import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/name_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class EditTrainerDetailsContentWidget extends StatelessWidget {
  const EditTrainerDetailsContentWidget({
    super.key,
    required this.descriptionController,
    required this.priceController,
    required this.fromHController,
    required this.toHController,
    required this.autovalidateMode,
    required this.formKey,
  });
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController fromHController;
  final TextEditingController toHController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addTextField(
              lable: S.of(context).trainer_description,
              controller: descriptionController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            addTextField(
              keyboardType: TextInputType.number,
              lable: S.of(context).price_sub,
              controller: priceController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            NameTextWidget(text: S.of(context).work_hour),
            const SizedBox(
              height: 5,
            ),
            addTextField(
              onTap: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  final DateTime now = DateTime.now();
                  final DateTime selectedTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    time.hour,
                    time.minute,
                  );

                  final DateFormat formatter = DateFormat('hh:mm a', 'en_US');
                  final String formattedTime = formatter.format(selectedTime);
                  fromHController.text = formattedTime;
                }
              },
              keyboardType: TextInputType.none,
              lable: S.of(context).from_w_h,
              controller: fromHController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
            addTextField(
              onTap: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  final DateTime now = DateTime.now();
                  final DateTime selectedTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    time.hour,
                    time.minute,
                  );

                  final DateFormat formatter = DateFormat('hh:mm a', 'en_US');
                  final String formattedTime = formatter.format(selectedTime);
                  toHController.text = formattedTime;
                }
              },
              keyboardType: TextInputType.none,
              lable: S.of(context).to_w_h,
              controller: toHController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
