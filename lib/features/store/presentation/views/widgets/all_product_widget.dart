import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/store_model/product_model.dart';
import '../products_category_screen.dart';

class AllProductsWidget extends StatelessWidget {
  const AllProductsWidget({super.key, required this.list});
  final List<ProductModel> list;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          ProductsCategoryScreen(list: list, title: S.of(context).allProducts),
        );
      },
      child: Container(
        alignment: Alignment.topRight,
        constraints: BoxConstraints(
          minHeight: 100.spMax,
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            image: AssetImage(Assets.imagesAllProduct),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).allProducts,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
