import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/loading_item_widget.dart';

import 'message_question_builder_widget.dart';
import 'question_item_widget.dart';

class QuestionItemStreamBuilderWidget extends StatefulWidget {
  const QuestionItemStreamBuilderWidget({
    super.key,
    required this.model,
  });
  final QuestionModel model;

  @override
  State<QuestionItemStreamBuilderWidget> createState() =>
      _QuestionItemStreamBuilderWidgetState();
}

class _QuestionItemStreamBuilderWidgetState
    extends State<QuestionItemStreamBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.model.askerUid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MessageQuestionBuilderWidget(
            message: snapshot.error.toString(),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingItemWidget();
        }
        if (snapshot.data != null) {
          Map<String, dynamic> map =
              snapshot.data!.data() as Map<String, dynamic>;
          UserModel model = UserModel.fromMap(map, snapshot.data!.id);
          log(model.image);
          return QuestionItemWidget(
            model: widget.model,
            user: model,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
