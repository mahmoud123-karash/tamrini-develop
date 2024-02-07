import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/rating_contet_widget.dart';

class ProductRatingScreen extends StatelessWidget {
  const ProductRatingScreen({super.key, required this.model});
  final Product model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).rating),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: RatingContentWidget(image: model.id, name: model.title),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: customButton(
                  onPressed: () {}, lable: S.of(context).back_to_home),
            ),
          )
        ],
      ),
    );
  }
}
