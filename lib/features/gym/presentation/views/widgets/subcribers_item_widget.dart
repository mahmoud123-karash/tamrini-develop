import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/gym/data/models/subscriber_model/subscriber_model.dart';

import 'payment_method_and_price_widget.dart';
import 'sub_end_date_row_widget.dart';
import 'subscriber_row_widget.dart';

class SubscribersItemWidget extends StatelessWidget {
  const SubscribersItemWidget(
      {super.key, required this.model, required this.user});
  final SubscriberModel model;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColor.withOpacity(0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SudscriberRowWidget(user: user),
              Divider(
                color: blackColor,
              ),
              SubEndDateRowWidget(
                subDate: model.subDate.toDate(),
                endDate: model.endDate.toDate(),
              ),
              const SizedBox(
                height: 10,
              ),
              PaymentMethodAndPriceWidget(
                price: model.paymentMethod.toString(),
                paymentMethod: model.paymentMethod,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
