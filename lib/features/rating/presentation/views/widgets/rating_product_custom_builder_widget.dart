import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/rating/presentation/manager/store_cubit/rating_cubit.dart';
import 'package:tamrini/features/rating/presentation/manager/store_cubit/rating_states.dart';
import 'package:tamrini/generated/l10n.dart';

class RatingProductCustomBuilderWidget extends StatelessWidget {
  const RatingProductCustomBuilderWidget({
    super.key,
    required this.storeId,
    required this.productId,
  });
  final String storeId, productId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingCubit, RatingStates>(
      listener: (context, state) {
        if (state is SucessRateProductState) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }

        if (state is ErrorRateProductState) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingRateProductState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(
              onPressed: () {
                if (RatingCubit.get(context).rating == 1) {
                  showSnackBar(context, S.of(context).rating_product_hint);
                } else {
                  RatingCubit.get(context).rateProduct(
                    storeId: storeId,
                    productId: productId,
                  );
                }
              },
              lable: S.of(context).back_to_home);
        }
      },
    );
  }
}
