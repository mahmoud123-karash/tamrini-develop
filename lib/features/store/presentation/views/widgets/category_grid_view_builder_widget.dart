import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/presentation/manager/category_cubit/category_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/category_cubit/category_states.dart';
import 'package:tamrini/features/store/presentation/views/widgets/category_grid_view_widget.dart';

class CategoryGridViewBuilderWidget extends StatelessWidget {
  const CategoryGridViewBuilderWidget({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryStates>(
      builder: (context, state) {
        if (state is SucessGetCategoriesState) {
          List<CategoryModel> list = [];
          for (var e in state.list) {
            List<ProductModel> categoryList =
                products.where((element) => element.type == e.title).toList();
            if (categoryList.isNotEmpty) {
              list.add(e);
            }
          }
          return GategoryGridViewWidget(
            list: list,
            products: products,
          );
        } else if (state is ErrorGetCategoriesState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                state.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
