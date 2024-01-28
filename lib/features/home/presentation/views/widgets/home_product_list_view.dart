import 'package:flutter/material.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_product_item_widget.dart';

class ProductsListViewWidget extends StatelessWidget {
  const ProductsListViewWidget({super.key, required this.models});
  final List<ProductModel> models;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidth = mediaQuery.size.width;

    return SizedBox(
      height: getHeight * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: models.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return HomeProductItemWidget(
            model: models[index],
            width: getWidth - 70,
            smodel: StoreCubit.get(context)
                .getStore(
                  models[index].ownerUid,
                )
                .first,
          );
        },
      ),
    );
  }
}
