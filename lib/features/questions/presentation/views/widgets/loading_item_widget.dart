import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/loading_share_widget.dart';
import 'loading_name_and_type_widget.dart';

class LoadingItemWidget extends StatelessWidget {
  const LoadingItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoadingNamwANdTypeWidget(),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: appColor.withOpacity(0.3),
            height: 20,
            width: double.infinity,
            child: const Text(
              '',
              style: TextStyle(
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
          Container(
            color: appColor.withOpacity(0.3),
            height: 20,
            width: 150,
          ),
          const Divider(),
          const LoadingQuestionShareAndCommentWidget(),
          const Divider(),
        ],
      ),
    );
  }
}
