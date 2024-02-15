import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/rating_contet_widget.dart';
import 'widgets/rating_product_custom_builder_widget.dart';

class ProductRatingScreen extends StatelessWidget {
  const ProductRatingScreen(
      {super.key, required this.model, required this.storeId});
  final Product model;
  final String storeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).rating),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: RatingContentWidget(
              image: model.image,
              name: model.title,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RatingProductCustomBuilderWidget(
                  storeId: storeId,
                  productId: model.id,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
