import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/custom_buy_now_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ContactAndBuyProductWidget extends StatelessWidget {
  const ContactAndBuyProductWidget({super.key, required this.contact});
  final String contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomBuyNowButtonWidget(
            onPressed: () {},
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
                path: contact,
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
