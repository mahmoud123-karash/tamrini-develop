import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/store/presentation/manager/category_cubit/category_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/category_cubit/category_states.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_type_widget.dart';

class ProductTypeListViewBuilderWidget extends StatelessWidget {
  const ProductTypeListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryStates>(
      builder: (context, state) {
        if (state is SucessGetCategoriesState) {
          return ProductTypeWidget(types: state.list);
        } else {
          return Container();
        }
      },
    );
  }
}
