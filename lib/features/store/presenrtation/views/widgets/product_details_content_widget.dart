import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../../core/services/services.dart';
import 'product_details_image_widget.dart';
import 'product_details_name_rating_widget.dart';
import 'product_details_price_widget.dart';

class ProductDetailsContentWidget extends StatelessWidget {
  const ProductDetailsContentWidget({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (model.bestSeller)
            const Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.stars_rounded,
                  color: Colors.amber,
                ),
              ),
            ),
          Center(
            child: ProductDetailsImageWidget(
              image: model.image,
            ),
          ),
          ProductDetailsNameRatingWidget(
            title: model.title,
            rating: calculateAverageRating(model.rating),
          ),
          const SizedBox(
            height: 10,
          ),
          ProductDetailsPriceWidget(
            price: model.price.toDouble(),
            oldPrice: model.oldPrice.toDouble(),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            S.of(context).description,
            style: TextStyles.style20Bold,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                (model.description),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}
