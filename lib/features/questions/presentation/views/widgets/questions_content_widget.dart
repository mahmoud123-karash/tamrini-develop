import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_states.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/message_question_builder_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/questions_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class QuestionContentWidget extends StatefulWidget {
  const QuestionContentWidget(
      {super.key, required this.list, required this.state});
  final List<QuestionModel> list;
  final QuestionStates state;

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
            searchField(
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
        if (widget.state is! SucessGetQuestionsState &&
            widget.state is! ErrorGetQuestionsState)
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: appColor.withOpacity(0.5),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
