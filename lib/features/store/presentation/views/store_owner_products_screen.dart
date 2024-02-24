import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/store_category_colum_widget.dart';

class StoreOwnerProductScreen extends StatelessWidget {
  const StoreOwnerProductScreen({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).store_owner_products),
      body: BlocBuilder<StoreCubit, StoreStates>(
        builder: (context, state) {
          StoreModel model = StoreCubit.get(context).getStore(uid).first;
          return StoreCategoryColumWidget(
            list: model.products ?? [],
          );
        },
      ),
    );
  }
}
