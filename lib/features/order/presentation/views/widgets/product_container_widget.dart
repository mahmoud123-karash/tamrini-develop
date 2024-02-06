import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/order/presentation/views/widgets/product_info_amount_widget.dart';

class ProductContainerWidget extends StatelessWidget {
  const ProductContainerWidget({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.amount,
  });
  final String name, image;
  final num price;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: greyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                width: 150,
                image: FirebaseImageProvider(
                  FirebaseUrl(image),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            ProductInfoAmountWidget(
              name: name,
              price: price,
              amount: amount,
            ),
          ],
        ),
      ),
    );
  }
}
