import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';

import 'widgets/category_content_builder_widget.dart';

class ProductsCategoryScreen extends StatefulWidget {
  const ProductsCategoryScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<ProductsCategoryScreen> createState() => _ProductsCategoryScreenState();
}

class _ProductsCategoryScreenState extends State<ProductsCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title),
      body: const CategoryContentBuilderWidget(),
    );
  }
}
