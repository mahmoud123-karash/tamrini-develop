import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/store/presenrtation/views/product_details.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/product_price_widget.dart';

import '../../../../home/data/models/store_model/product_model.dart';

class StoreProductItemWidget extends StatelessWidget {
  const StoreProductItemWidget({
    super.key,
    required this.model,
  });
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          navigateTo(
              context,
              ProductDetailsScreen(
                model: model,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 0.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (model.bestSeller)
                const Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.stars_rounded,
                      color: Colors.amber,
                    ),
                  ),
                ),
              Container(
                width: getWidht / 3.5,
                height: getHeight / 6,
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FirebaseImageProvider(
                      FirebaseUrl(model.image),
                      options: const CacheOptions(
                        checkForMetadataChange: false,
                      ),
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  model.title,
                  style: TextStyles.style13.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              ProductPriceWidget(
                mainAxisAlignment: MainAxisAlignment.center,
                price: model.price.toStringAsFixed(1),
                oldPrice: model.oldPrice.toStringAsFixed(1),
                spacer: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
