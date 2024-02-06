import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';

import 'product_order_details_widget.dart';

class OrderProductWidget extends StatelessWidget {
  const OrderProductWidget(
      {super.key, required this.title, required this.qty, required this.image});
  final String title;
  final String qty;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 120,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FirebaseImageProvider(
                FirebaseUrl(image),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        ProductOrderDetailsWidget(title: title, qty: qty)
      ],
    );
  }
}
