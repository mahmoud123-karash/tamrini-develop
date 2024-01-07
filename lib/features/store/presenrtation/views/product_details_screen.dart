import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presenrtation/views/store_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/contact_and_buy_product_widget.dart';
import 'widgets/product_details_content_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.model, this.sModel})
      : super(key: key);
  final ProductModel model;
  final StoreModel? sModel;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHight = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).proDetails),
        centerTitle: true,
        actions: [
          if (sModel != null)
            IconButton(
              onPressed: () {
                if (sModel == null) {
                  Navigator.pop(context);
                } else {
                  navigateTo(context, StoreScreen(model: sModel!));
                }
              },
              icon: const Icon(
                Ionicons.storefront,
              ),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          height: getHight,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: ProductDetailsContentWidget(model: model),
                ),
              ),
              ContactAndBuyProductWidget(
                contact: model.contact,
              )
            ],
          ),
        ),
      ),
    );
  }
}
