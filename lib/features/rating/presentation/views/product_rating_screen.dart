import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/rating/data/repo/rating_repo_impl.dart';
import 'package:tamrini/features/rating/presentation/manager/store_cubit/rating_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/rating_contet_widget.dart';
import 'widgets/rating_product_custom_builder_widget.dart';

class ProductRatingScreen extends StatelessWidget {
  const ProductRatingScreen(
      {super.key, required this.model, required this.storeId});
  final Product model;
  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingCubit(
        getIt.get<RatingRepoImpl>(),
      ),
      child: Scaffold(
        appBar: myAppBar(S.of(context).rating),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: RatingContentWidget(
                image: model.image,
                name: model.title,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RatingProductCustomBuilderWidget(
                    storeId: storeId,
                    productId: model.id,
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
