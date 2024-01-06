import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presenrtation/views/products_category_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class OtherCategoryItemWidget extends StatelessWidget {
  const OtherCategoryItemWidget({super.key, required this.list});
  final List<ProductModel> list;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context,
            ProductsCategoryScreen(list: list, title: S.of(context).other));
      },
      child: Container(
        alignment: Alignment.topRight,
        constraints: const BoxConstraints(
          minHeight: 100,
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            image: AssetImage(Assets.imagesAllProduct),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: AutoSizeText(
              S.of(context).other,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
