import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/user_name_type_and_answer_date_loading_widget.dart';

class AnswerLoadingItemWidgt extends StatelessWidget {
  const AnswerLoadingItemWidgt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          greyColor,
          appColor.withOpacity(0.3),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: appColor.withOpacity(0.2),
            ),
            const SizedBox(
              width: 15,
            ),
            const NameAswertypeUserLoadingWidget(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
