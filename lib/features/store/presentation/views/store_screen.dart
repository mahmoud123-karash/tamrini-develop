import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/custom_group_buttons_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_grid_view_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_best_seller_product_list_view_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_cover_image_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key, required this.model});
  final StoreModel model;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  bool isTapped = true;
  @override
  Widget build(BuildContext context) {
    final EdgeInsets systemPadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: systemPadding.top + systemPadding.bottom,
          ),
          StoreCoverImageWidget(
            name: widget.model.name,
            contact: widget.model.contact,
            uid: widget.model.storeOwnerUid,
            image: widget.model.image,
            num: widget.model.products!.length,
          ),
          CustomGroupButtonWidget(
            onPressedP: () {
              isTapped = true;
              setState(() {});
            },
            onPressedB: () {
              isTapped = false;
              setState(() {});
            },
            isTapped: isTapped,
          ),
          Expanded(
            child: isTapped
                ? ProductGridViewWidget(
                    models: widget.model.products!
                        .where((element) => element.available)
                        .toList(),
                  )
                : StoreBestSellerProducctListViewWidget(
                    list: widget.model.products!
                        .where((element) => element.bestSeller)
                        .toList(),
                  ),
          )
        ],
      ),
    );
  }
}
