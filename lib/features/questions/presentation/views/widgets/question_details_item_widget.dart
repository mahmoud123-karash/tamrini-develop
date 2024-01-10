import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    required this.body,
    required this.answersCount,
    required this.date,
  });
  final String name, image, type, uid, body, answersCount;
  final Timestamp date;

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
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              body,
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
              body: body, answersCount: answersCount),
          const Divider(),
        ],
      ),
    );
  }
}
