import 'package:flutter/material.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_cover_image_widget.dart';

import 'widgets/store_category_colum_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key, required this.model});
  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets systemPadding = MediaQuery.of(context).padding;
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: systemPadding.top + systemPadding.bottom,
            ),
            StoreCoverImageWidget(
              isBanned: model.isBanned,
              name: model.name,
              contact: model.contact,
              uid: model.storeOwnerUid,
              image: model.image,
              num: model.products!.length,
            ),
            StoreCategoryColumWidget(
              list: model.products ?? [],
            )
          ],
        ),
      ),
    );
  }
}
