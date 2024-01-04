import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/product_price_widget.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/product_rating_widget.dart';

import '../product_details.dart';
import 'product_image_widget.dart';

class StoreBestSellerProductItemWidget extends StatelessWidget {
  const StoreBestSellerProductItemWidget({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProductDetailsScreen(model: model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x7F000000),
                blurRadius: 200,
                offset: Offset(4, 8),
                spreadRadius: -40,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ProductImageWidget(
                  image: model.image,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: getWidht - ((getWidht / 3.7) + 24 + 30 + 20),
                      ),
                      child: Text(
                        model.title,
                        style: TextStyles.style16Bold,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: getWidht - ((getWidht / 3.7) + 24 + 30 + 20),
                      ),
                      child: Text(
                        model.description,
                        style: TextStyles.style13.copyWith(
                          color: greyColor,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    ProductRatingWidget(
                      rating: calculateAverageRating(model.rating),
                    ),
                    ProductPriceWidget(
                      mainAxisAlignment: MainAxisAlignment.start,
                      price: model.price.toStringAsFixed(1),
                      spacer: 25,
                      oldPrice: model.oldPrice!.toStringAsFixed(1),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
