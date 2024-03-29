import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/add_question_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import '../../manager/question_cubit/question_cubit.dart';
import 'add_question_text_field_widget.dart';

class AddQuestionBottomSheetWidget extends StatefulWidget {
  const AddQuestionBottomSheetWidget({super.key});

  @override
  State<AddQuestionBottomSheetWidget> createState() =>
      _AddQuestionBottomSheetWidgetState();
}

class _AddQuestionBottomSheetWidgetState
    extends State<AddQuestionBottomSheetWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              AddQuestionTextFieldWidget(
                hint: S.of(context).write_question,
                controller: controller,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (controller.text != '')
                AddQuestionCustomButtonBuilderWidget(
                  controller: controller,
                  lable: S.of(context).add,
                  onPressed: () {
                    QuestionCubit.get(context).addNewQuestion(
                        body: controller.text, context: context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
