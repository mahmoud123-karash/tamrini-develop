import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/generated/l10n.dart';

class LoadingQuestionShareAndCommentWidget extends StatelessWidget {
  const LoadingQuestionShareAndCommentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Expanded(
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.imagesComment),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    '${0}  ${S.of(context).answer}',
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
          ],
        ),
      ),
    );
  }
}
