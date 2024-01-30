import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/product_details_screen.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_info_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/remove_product_icon_widget.dart';

import 'unavailable_badge_widget.dart';

class ProductStoreItemWidget extends StatelessWidget {
  const ProductStoreItemWidget({
    super.key,
    required this.model,
    required this.sModel,
  });
  final ProductModel model;
  final StoreModel sModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProductDetailsScreen(id: model.id, sModel: sModel));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          alignment: Intl.getCurrentLocale() == 'ar'
              ? Alignment.topLeft
              : Alignment.topRight,
          children: [
            Container(
              height: 140.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                        width: 120.w,
                        height: 140.h,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: FirebaseImageProvider(
                                FirebaseUrl(model.image),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      if (!model.available) const UnAvailableBadgeWidget(),
                    ],
                  ),
                  ProductInfoWidget(model: model),
                ],
              ),
            ),
            RemoveProductIconWidget(
              model: model,
              store: sModel,
            ),
          ],
        ),
      ),
    );
  }
}