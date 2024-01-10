import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_details_item_widget.dart';
import 'answers_list_view_widget.dart';

class AnswersDetailsContentWidget extends StatefulWidget {
  const AnswersDetailsContentWidget({
    super.key,
    required this.list,
    required this.body,
    required this.answersCount,
    required this.name,
    required this.image,
    required this.type,
    required this.uid,
    required this.date,
  });
  final List<AnswerModel> list;
  final String name, image, type, uid, body, answersCount;
  final Timestamp date;

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
      if (widget.list.length > length) {
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
            body: widget.body,
            answersCount: widget.answersCount,
            date: widget.date,
          ),
          AnswerslistViewWidget(list: widget.list, length: length),
        ],
      ),
    );
  }
}
