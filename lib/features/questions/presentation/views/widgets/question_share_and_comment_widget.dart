import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import '../answers_screen.dart';

class QuestionShareAndCommentWidget extends StatelessWidget {
  const QuestionShareAndCommentWidget({
    super.key,
    required this.model,
    required this.uid,
    required this.body,
    required this.answersCount,
  });
  final UserModel model;
  final String uid, body, answersCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                onPressed: () async {
                  await share(
                    title: S.of(context).add_answer,
                    text: body,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Ionicons.share_outline,
                      color: Color(0xFF687684),
                      size: 20,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      S.of(context).share,
                      style: const TextStyle(
                        color: Color(0xFF687684),
                        fontSize: 15,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {
                  navigateTo(
                    context,
                    AnswersScreen(model: model, uid: uid),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesComment),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      '${answersCount.toString()}  ${S.of(context).answer}',
                      style: const TextStyle(
                        color: Color(0xFF687684),
                        fontSize: 15,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
