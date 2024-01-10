import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/loading_question_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/message_question_builder_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/questions_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class QuestionsStreamBuilderWidget extends StatelessWidget {
  const QuestionsStreamBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MessageQuestionBuilderWidget(
            message: snapshot.error.toString(),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingQuestionWidget();
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return MessageQuestionBuilderWidget(
            message: S.of(context).no_results,
          );
        } else {
          List<QuestionModel> list = [];
          for (var element in snapshot.data!.docs) {
            Map<String, dynamic> map = element.data() as Map<String, dynamic>;
            QuestionModel model = QuestionModel.fromJson(map, element.id);
            list.add(model);
          }
          List<QuestionModel> finalList =
              list.where((element) => element.isBanned == false).toList();
          return QuestionsListViewWidget(list: finalList);
        }
      },
    );
  }
}
