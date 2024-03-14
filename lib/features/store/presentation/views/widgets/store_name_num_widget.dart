import 'package:flutter/material.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_number_products_widget.dart';

class StoreNameNumWidget extends StatelessWidget {
  const StoreNameNumWidget({super.key, required this.name, required this.num});
  final String name;
  final int num;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width / 2),
          alignment: Alignment.bottomRight,
          child: Text(
            name,
            maxLines: 1,
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
