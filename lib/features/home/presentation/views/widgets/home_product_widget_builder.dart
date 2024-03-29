import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_loading_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_message_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_product_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeProductWidgetBuilder extends StatelessWidget {
  const HomeProductWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreStates>(
      builder: (context, state) {
        if (state is SucessGetStoresState) {
          if (state.list.isEmpty) {
            return Container();
          } else {
            List<ProductModel> list = genrateHomeList(state);
            List<ProductModel> allProducts = generatProductsList(state);
            return HomeProductWidget(
              allProducts: allProducts,
              products: list.where((element) => element.available).toList(),
            );
          }
        } else if (state is ErrorGetStoresState) {
          return HomeMessageWidget(message: state.message);
        } else {
          return HomeLoadingWidget(
            lable: S.of(context).products,
          );
        }
      },
    );
  }
}

List<ProductModel> genrateHomeList(SucessGetStoresState state) {
  Random random = Random();
  List<ProductModel> list = [];
  for (var element in state.list) {
    if (element.products!.isNotEmpty) {
      ProductModel model =
          element.products![random.nextInt(element.products!.length)];
      if (list.length < 5) {
        if (model.available) {
          list.add(model);
        }
      }
    }
  }
  return list;
}

List<ProductModel> generatProductsList(SucessGetStoresState state) {
  List<ProductModel> list = [];
  for (var element in state.list) {
    List<ProductModel> model = element.products!
        .where((element) => element.available == true)
        .toList();
    list.addAll(model);
  }
  return list;
}
