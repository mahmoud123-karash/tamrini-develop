import 'package:flutter/material.dart';
import 'package:tamrini/features/order/presentation/views/widgets/product_qty_widget.dart';

class ProductOrderDetailsWidget extends StatelessWidget {
  const ProductOrderDetailsWidget(
      {super.key, required this.title, required this.qty});
  final String title;
  final String qty;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          ProductQtyWidget(qty: qty)
        ],
      ),
    );
  }
}
