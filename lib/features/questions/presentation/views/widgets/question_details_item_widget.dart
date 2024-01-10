import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_name_Image_type_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_time_and_date_widget.dart';

import 'share_and_answer_details_question.dart';

class QuestionDetailsItemWidget extends StatelessWidget {
  const QuestionDetailsItemWidget({
    super.key,
    required this.name,
    required this.image,
    required this.type,
    required this.uid,
    required this.answersCount,
    required this.date,
    required this.model,
  });
  final String name, image, type, uid, answersCount;
  final Timestamp date;
  final QuestionModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionOwnerNameImageTypeWidget(
            image: image,
            name: name,
            type: type,
            uid: uid,
            model: model,
            isDetails: true,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              model.body,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w300,
                letterSpacing: -0.70,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: QuestionTimeAndDateWidget(
              date: DateFormat('MM/dd/yy', 'en').format(date.toDate()),
              time: DateFormat('h:mm a', 'en').format(date.toDate()),
            ),
          ),
          const Divider(),
          QuestionDetailsShareAndCommentWidget(
              body: model.body, answersCount: answersCount),
          const Divider(),
        ],
      ),
    );
  }
}
