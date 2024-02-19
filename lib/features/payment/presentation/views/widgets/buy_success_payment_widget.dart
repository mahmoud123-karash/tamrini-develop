import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/presentation/views/summary_order_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class BuySuccessPaymentWidget extends StatelessWidget {
  const BuySuccessPaymentWidget({
    super.key,
    required this.model,
    required this.name,
    required this.phone,
    required this.address,
    required this.storeId,
  });
  final Product model;
  final String name, phone, address, storeId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            child: Center(
              child: Icon(
                Icons.done,
                color: appColor,
                size: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).payment_success,
            style: TextStyles.style16Bold.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          customButton(
            onPressed: () {
              navigateTo(
                context,
                SummaryOrderScreen(
                  model: model,
                  name: name,
                  phone: phone,
                  address: address,
                  storeId: storeId,
                ),
              );
            },
            lable: S.of(context).next,
          )
        ],
      ),
    );
  }
}
