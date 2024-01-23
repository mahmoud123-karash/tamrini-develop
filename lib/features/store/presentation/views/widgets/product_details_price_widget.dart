import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/store/presentation/views/widgets/dinar_text_widget.dart';

class ProductDetailsPriceWidget extends StatelessWidget {
  const ProductDetailsPriceWidget(
      {super.key, required this.price, required this.oldPrice});
  final double price, oldPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 80),
          child: Text(
            price.toStringAsFixed(1),
            style: TextStyles.style17,
            maxLines: 1,
          ),
        ),
        const DinarTextWidget(),
        const Spacer(),
        if (oldPrice != 0)
          Container(
            constraints: const BoxConstraints(maxWidth: 80),
            child: Text(
              oldPrice.toStringAsFixed(1),
              style: TextStyles.style17.copyWith(
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
              ),
              maxLines: 1,
            ),
          ),
        if (oldPrice != 0) const DinarTextWidget(),
      ],
    );
  }
}
