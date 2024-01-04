import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class HomeProductPriceWidget extends StatelessWidget {
  const HomeProductPriceWidget(
      {super.key,
      required this.price,
      required this.oldPrice,
      required this.spacer,
      required this.mainAxisAlignment});
  final String price, oldPrice;
  final double spacer;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 60),
          child: Text(
            price,
            style: TextStyles.style13.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(
          width: spacer,
        ),
        if (oldPrice != '0.0')
          Container(
            constraints: const BoxConstraints(maxWidth: 60),
            child: Text(
              oldPrice,
              style: TextStyles.style13.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
              ),
              maxLines: 1,
            ),
          )
      ],
    );
  }
}
