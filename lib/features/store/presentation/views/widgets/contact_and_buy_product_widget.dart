import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/presentation/views/address_screen.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/custom_buy_now_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ContactAndBuyProductWidget extends StatelessWidget {
  const ContactAndBuyProductWidget({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    String usertype = CacheHelper.getData(key: 'usertype');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (usertype != 'admin' && usertype != 'store onwer')
            CustomBuyNowButtonWidget(
              onPressed: () {
                navigateTo(context, AddressScreen(model: model));
              },
              lable: S.of(context).buyNow,
              color: appColor,
            ),
          const SizedBox(
            width: 10,
          ),
          CustomBuyNowButtonWidget(
            onPressed: () {
              Uri messageUri = Uri(
                scheme: 'sms',
                path: model.contact,
              );
              openUri(url: messageUri);
            },
            lable: S.of(context).contactUs,
            color: whiteColor,
          ),
        ],
      ),
    );
  }
}
