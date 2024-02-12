import 'package:flutter/widgets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

class AddRepAndRepeatRowWidget extends StatelessWidget {
  const AddRepAndRepeatRowWidget(
      {super.key,
      required this.numRController,
      required this.numPController,
      required this.autovalidateMode,
      required this.formKey});
  final TextEditingController numRController;
  final TextEditingController numPController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: addTextField(
                keyboardType: TextInputType.number,
                lable: S.of(context).num_of_reps,
                controller: numRController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: addTextField(
                keyboardType: TextInputType.number,
                lable: S.of(context).num_of_repeat,
                controller: numPController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
            )
          ],
        ),
      ),
    );
  }
}
