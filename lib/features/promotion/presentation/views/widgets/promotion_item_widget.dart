import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';
import 'accept_refuse_buttons_widget.dart';
import 'promotion_type_widget.dart';
import 'promotion_user_image_name_widget.dart';

class PromotionItemWidget extends StatelessWidget {
  const PromotionItemWidget({super.key, required this.model});
  final PromotionModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Intl.getCurrentLocale() == 'ar'
                  ? Alignment.bottomLeft
                  : Alignment.bottomRight,
              child: Text(
                Intl.getCurrentLocale() == 'ar'
                    ? formatTimeDifferenceInArabic(model.requestTime.toDate())
                    : formatTimeDifference(model.requestTime.toDate()),
                style: TextStyles.style14,
              ),
            ),
            model.user == null
                ? Container()
                : PromotionUserImageNameWidget(
                    user: model.user!,
                  ),
            const SizedBox(
              height: 10,
            ),
            PromotionTypeWidget(promotionType: model.promotionType),
            const SizedBox(
              height: 20,
            ),
            AcceptRefuseButtonWidget(model: model),
          ],
        ),
      ),
    );
  }
}
