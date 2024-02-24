import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/all_container_widget.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/views/products_category_screen.dart';
import 'package:tamrini/features/store/presentation/views/widgets/category_grid_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({
    super.key,
    required this.list,
  });
  final List<ProductModel> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      appBar: myAppBar(
        S.of(context).category,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AllContainerWidget(
                onPressed: () {
                  StoreCubit.get(context).displayedList = list;
                  navigateTo(context,
                      ProductsCategoryScreen(title: S.of(context).allProducts));
                },
                image: Assets.imagesAllProduct,
                lable: S.of(context).allProducts,
              ),
              const SizedBox(
                height: 10,
              ),
              CategoryGridViewBuilderWidget(
                products: list,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
