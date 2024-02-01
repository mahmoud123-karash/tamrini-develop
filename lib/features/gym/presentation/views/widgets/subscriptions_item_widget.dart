import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/subscription_model/subscription_model.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscription_gym_details_widget.dart';
import 'gym_slide_show_images_widget.dart';
import 'payment_method_and_price_widget.dart';
import 'sub_end_date_row_widget.dart';

class SubscribtionsItemWidget extends StatelessWidget {
  const SubscribtionsItemWidget(
      {super.key, required this.model, required this.gym});
  final SubscriptionModel model;
  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColor.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubscriptionGymDetailsWidget(gym: gym),
              const SizedBox(
                height: 5,
              ),
              GymSlideShowImagesWidget(
                assets: gym.assets,
                name: gym.description,
              ),
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
                price: model.price.toString(),
                paymentMethod: model.paymentMethod,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
