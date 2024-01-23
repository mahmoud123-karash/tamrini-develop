import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/category_model.dart';
import 'package:tamrini/features/store/presentation/views/products_category_screen.dart';

class CategoryProductItemWidget extends StatelessWidget {
  const CategoryProductItemWidget(
      {super.key, required this.model, required this.list, required this.name});
  final CategoryModel model;
  final List<ProductModel> list;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProductsCategoryScreen(list: list, title: name));
      },
      child: Container(
        alignment: Alignment.topRight,
        constraints: const BoxConstraints(
          minHeight: 100,
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            colorFilter:
                const ColorFilter.mode(Colors.black45, BlendMode.darken),
            image: FirebaseImageProvider(
              FirebaseUrl(model.image),
              options: const CacheOptions(
                checkForMetadataChange: false,
              ),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: AutoSizeText(
              name,
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
