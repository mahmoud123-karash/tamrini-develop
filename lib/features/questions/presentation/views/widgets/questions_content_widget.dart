import 'package:flutter/material.dart';
import 'package:tamrini/core/services/serach.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/message_question_builder_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/questions_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../home/presentation/views/widgets/search_text_field_widget.dart';

class QuestionContentWidget extends StatefulWidget {
  const QuestionContentWidget({super.key, required this.list});
  final List<QuestionModel> list;

  @override
  State<QuestionContentWidget> createState() => _QuestionContentWidgetState();
}

class _QuestionContentWidgetState extends State<QuestionContentWidget> {
  TextEditingController controller = TextEditingController();
  List<QuestionModel> searchList = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SearchTextFieldWidget(
              controller: controller,
              onChanged: (value) {
                searchList = searchQuestion(value, widget.list);
                setState(() {});
              },
            ),
            Expanded(
              child: QuestionsListViewWidget(
                list: controller.text == '' ? widget.list : searchList,
              ),
            )
          ],
        ),
        if (controller.text != '' && searchList.isEmpty)
          MessageQuestionBuilderWidget(message: S.of(context).no_results),
      ],
    );
  }
}
