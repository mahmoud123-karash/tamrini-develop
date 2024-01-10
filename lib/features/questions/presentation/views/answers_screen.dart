import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/answers_details_content_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/write_answer_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../data/models/question_model/question_model.dart';
import 'widgets/message_question_builder_widget.dart';

class AnswersScreen extends StatelessWidget {
  const AnswersScreen({super.key, required this.model, required this.uid});
  final UserModel model;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).answers),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Q&A')
            .doc('questions')
            .collection('questions')
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MessageQuestionBuilderWidget(
              message: snapshot.error.toString(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MessageQuestionBuilderWidget(message: 'Loading...');
          }
          if (snapshot.data != null) {
            Map<String, dynamic> map =
                snapshot.data!.data() as Map<String, dynamic>;
            QuestionModel question = QuestionModel.fromJson(
              map,
              uid,
            );
            log(question.answers.length.toString());
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: AnswersDetailsContentWidget(
                    list: question.answers,
                    body: question.body,
                    answersCount: question.answersCount.toString(),
                    name: model.name,
                    image: model.image,
                    type: getQuestionUserType(model),
                    uid: model.uid,
                    date: question.date,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: WriteAnswerWidget(),
                ),
              ],
            );
          } else {
            return MessageQuestionBuilderWidget(
              message: S.of(context).question_error,
            );
          }
        },
      ),
    );
  }
}
