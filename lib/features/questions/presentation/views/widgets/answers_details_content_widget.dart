import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_details_item_widget.dart';
import 'answers_list_view_widget.dart';

class AnswersDetailsContentWidget extends StatefulWidget {
  const AnswersDetailsContentWidget({
    super.key,
    required this.model,
    required this.name,
    required this.image,
    required this.type,
    required this.uid,
  });
  final String name, image, type, uid;
  final QuestionModel model;

  @override
  State<AnswersDetailsContentWidget> createState() =>
      _AnswersDetailsContentWidgetState();
}

class _AnswersDetailsContentWidgetState
    extends State<AnswersDetailsContentWidget> {
  ScrollController scrollController = ScrollController();

  int length = 10;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.model.answers.length > length) {
        length += 10;
        WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          QuestionDetailsItemWidget(
            name: widget.name,
            image: widget.image,
            type: widget.type,
            uid: widget.uid,
            answersCount: widget.model.answersCount.toString(),
            date: widget.model.date,
            model: widget.model,
          ),
          AnswerslistViewWidget(list: widget.model.answers, length: length),
        ],
      ),
    );
  }
}
