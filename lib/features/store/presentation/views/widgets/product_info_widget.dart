import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/new_badge_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_rating_widget.dart';

import 'product_price_widget.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: getWidht - (120.w + 10 + 25),
          ),
          child: Text(
            model.title,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: getWidht - (120.w + 10 + 25),
          ),
          child: Text(
            model.description,
            maxLines: 2,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        model.rating.isEmpty
            ? const NewBadgeWidget()
            : ProductRatingWidget(
                rating: calculateAverageRating(model.rating),
              ),
        ProductPriceWidget(
          price: model.price.toStringAsFixed(1),
          oldPrice: model.oldPrice.toStringAsFixed(1),
          spacer: 5,
          mainAxisAlignment: MainAxisAlignment.start,
        )
      ],
    );
  }
}
