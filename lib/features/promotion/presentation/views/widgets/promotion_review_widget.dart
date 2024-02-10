import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/promotion_model/promotion_model.dart';

class PromotionReviewWidget extends StatelessWidget {
  const PromotionReviewWidget({super.key, required this.model});
  final PromotionModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.done_all,
          color: appColor,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          S.of(context).request_promotion_done,
          style: TextStyles.style16Bold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          model.promotionType,
          style: TextStyles.style16Bold.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          S.of(context).promotion_reqiest_review,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          Intl.getCurrentLocale() == 'ar'
              ? formatTimeDifferenceInArabic(
                  model.requestTime.toDate(),
                )
              : formatTimeDifference(
                  model.requestTime.toDate(),
                ),
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
