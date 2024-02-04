import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/nutrition/presentation/manager/classification_cubit/classification_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/manager/classification_cubit/classification_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/nutrition_model/classification_model.dart';

class NewClassificationDialogWidget extends StatefulWidget {
  const NewClassificationDialogWidget({super.key, this.model});
  final ClassificationModel? model;

  @override
  State<NewClassificationDialogWidget> createState() =>
      _NewClassificationDialogWidgetState();
}

class _NewClassificationDialogWidgetState
    extends State<NewClassificationDialogWidget> {
  TextEditingController controller = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.model != null) {
      controller.text = widget.model!.classification;
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.model != null
            ? S.of(context).edit_nutrition_classification
            : S.of(context).add_nutrition_classification,
        style: TextStyles.style14.copyWith(
          fontWeight: FontWeight.bold,
          color: appColor,
        ),
      ),
      content: Form(
        key: formKey,
        child: addTextField(
          lable: S.of(context).classification_name,
          controller: controller,
          context: context,
          autovalidateMode: autovalidateMode,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            S.of(context).cancel,
            style: TextStyles.style13.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        BlocBuilder<ClassificationCubit, ClassificationStates>(
          builder: (context, state) => TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                if (widget.model != null) {
                } else {}
              } else {
                autovalidateMode = AutovalidateMode.always;
                setState(() {});
              }
            },
            child: Text(
              widget.model != null ? S.of(context).edit : S.of(context).add,
              style: TextStyles.style13.copyWith(
                fontWeight: FontWeight.bold,
                color: appColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
