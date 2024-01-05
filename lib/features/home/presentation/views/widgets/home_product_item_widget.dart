import 'package:flutter/material.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_image_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_product_price_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/new_badge_widget.dart';
import 'package:tamrini/features/store/presenrtation/views/product_details.dart';

import 'home_product_rating_widget.dart';

class HomeProductItemWidget extends StatelessWidget {
  const HomeProductItemWidget({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          navigateTo(context, ProductDetailsScreen(model: model));
        },
        child: Stack(
          children: [
            HomeImageWidget(
              image: model.image,
              width: getWidht - 70,
            ),
            calculateAverageRating(model.rating) == 0
                ? const NewBadgeWidget()
                : model.bestSeller
                    ? const Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.stars_rounded,
                            color: Colors.amber,
                          ),
                        ),
                      )
                    : Container(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: getHeight * 0.18,
                constraints: const BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[500],
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueGrey[900]!.withOpacity(0.0),
                      Colors.blueGrey[500]!.withOpacity(0.5),
                      Colors.blueGrey[500]!.withOpacity(0.8),
                      Colors.blueGrey[500]!.withOpacity(1.0),
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          model.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (calculateAverageRating(model.rating) != 0)
                        HomeProductRatingWidget(
                          rating: calculateAverageRating(model.rating),
                        ),
                      HomeProductPriceWidget(
                        price: model.price.toStringAsFixed(1),
                        oldPrice: model.oldPrice.toStringAsFixed(1),
                        spacer: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
