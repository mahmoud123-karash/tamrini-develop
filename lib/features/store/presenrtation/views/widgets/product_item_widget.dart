import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presenrtation/views/product_details_screen.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/product_info_widget.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget(
      {super.key, required this.model, required this.sModel});
  final ProductModel model;
  final StoreModel sModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            ProductDetailsScreen(
              model: model,
              sModel: sModel,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
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
              SizedBox(
                width: 120.w,
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
              ProductInfoWidget(model: model),
            ],
          ),
        ),
      ),
    );
  }
}
