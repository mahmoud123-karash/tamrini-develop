import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/manager/answer_cubit/answer_cubit.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/add_question_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'add_question_text_field_widget.dart';

class EditAnswerBottomSheetWidget extends StatefulWidget {
  const EditAnswerBottomSheetWidget(
      {super.key, required this.model, required this.question});
  final AnswerModel model;
  final QuestionModel question;

  @override
  State<EditAnswerBottomSheetWidget> createState() =>
      _EditAnswerBottomSheetWidgetState();
}

class _EditAnswerBottomSheetWidgetState
    extends State<EditAnswerBottomSheetWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.text = widget.model.answer;
    super.initState();
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
                hint: S.of(context).edit_answer,
                controller: controller,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (controller.text != '' &&
                  controller.text != widget.model.answer)
                AddQuestionCustomButtonBuilderWidget(
                  controller: controller,
                  lable: S.of(context).edit_question,
                  onPressed: () {
                    AnswerCubit.get(context).updateAnswer(
                      aModel: widget.model,
                      model: widget.question,
                      context: context,
                      id: widget.question.id!,
                      newAnswer: controller.text,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
