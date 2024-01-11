import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_cubit.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/add_question_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'add_question_text_field_widget.dart';

class EditQuestionBottomSheetWidget extends StatefulWidget {
  const EditQuestionBottomSheetWidget({super.key, required this.model});
  final QuestionModel model;

  @override
  State<EditQuestionBottomSheetWidget> createState() =>
      _EditQuestionBottomSheetWidgetState();
}

class _EditQuestionBottomSheetWidgetState
    extends State<EditQuestionBottomSheetWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.text = widget.model.body;
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
                hint: S.of(context).write_question,
                controller: controller,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (controller.text != '' && controller.text != widget.model.body)
                AddQuestionCustomButtonBuilderWidget(
                  controller: controller,
                  lable: S.of(context).edit_question,
                  onPressed: () {
                    QuestionCubit.get(context).updateQuestion(
                      model: QuestionModel(
                        date: widget.model.date,
                        body: controller.text,
                        askerUid: widget.model.askerUid,
                        answersCount: widget.model.answersCount,
                        answers: widget.model.answers,
                        isBanned: widget.model.isBanned,
                      ),
                      context: context,
                      id: widget.model.id!,
                      message: S.of(context).success_update,
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
