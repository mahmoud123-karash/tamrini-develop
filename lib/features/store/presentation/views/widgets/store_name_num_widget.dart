import 'package:flutter/material.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_number_products_widget.dart';

class StoreNameNumWidget extends StatelessWidget {
  const StoreNameNumWidget({super.key, required this.name, required this.num});
  final String name;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        StoreNumberProductsWidget(num: num)
      ],
    );
  }
}
