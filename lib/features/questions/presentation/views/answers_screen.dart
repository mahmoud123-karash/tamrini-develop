import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/answers_details_content_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/write_answer_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import '../../data/models/question_model/question_model.dart';
import 'widgets/message_question_builder_widget.dart';

class AnswersScreen extends StatefulWidget {
  const AnswersScreen({super.key, required this.model, required this.uid});
  final UserModel model;
  final String uid;

  @override
  State<AnswersScreen> createState() => _AnswersScreenState();
}

class _AnswersScreenState extends State<AnswersScreen> {
  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';

    return Scaffold(
      appBar: myAppBar(
        S.of(context).answers,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Q&A')
            .doc('questions')
            .collection('questions')
            .doc(widget.uid)
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
            Map<String, dynamic> map = {};
            if (snapshot.data!.data() != null) {
              map = snapshot.data!.data() as Map<String, dynamic>;
            }
            QuestionModel question = QuestionModel.fromJson(
              map,
              widget.uid,
              widget.model,
            );
            log(question.answers.length.toString());
            return snapshot.data!.data() == null
                ? MessageQuestionBuilderWidget(
                    message: S.of(context).question_error,
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: AnswersDetailsContentWidget(
                          user: widget.model,
                          model: question,
                        ),
                      ),
                      if (uid != '')
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: WriteAnswerWidget(
                            model: question,
                            token: widget.model.token,
                          ),
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
