import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';

import 'package:tamrini/features/questions/presentation/views/widgets/question_name_Image_type_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/question_time_and_date_widget.dart';

import 'question_share_and_comment_widget.dart';

class QuestionItemWidget extends StatelessWidget {
  const QuestionItemWidget({
    super.key,
    required this.model,
    required this.user,
  });
  final QuestionModel model;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionOwnerNameImageTypeWidget(
            image: user.image,
            name: user.name,
            type: getQuestionUserType(user),
            uid: user.uid,
            model: model,
            isDetails: false,
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
              date: DateFormat('MM/dd/yy', 'en').format(model.date.toDate()),
              time: DateFormat('h:mm a', 'en').format(model.date.toDate()),
            ),
          ),
          const Divider(),
          QuestionShareAndCommentWidget(
            model: user,
            answersCount: model.answersCount.toString(),
            body: model.body,
            uid: model.id!,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
