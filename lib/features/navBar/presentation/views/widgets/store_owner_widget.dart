import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/features/store/presentation/views/store_owner_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../../core/shared/components.dart';
import '../../../../store/presentation/views/new_store_screen.dart';

class StoreOwnerWidget extends StatelessWidget {
  const StoreOwnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return BlocBuilder<StoreCubit, StoreStates>(
      builder: (context, state) {
        if (state is SucessGetStoresState) {
          return DrawerListTileWidget(
            onPressed: () {
              List<StoreModel> list = StoreCubit.get(context).getStore(uid);
              if (list.isEmpty) {
                navigateTo(context, const NewStoreScreen());
              } else {
                navigateTo(context, const StoreOwnerScreen());
              }
            },
            icon: Ionicons.storefront_outline,
            lable: S.of(context).store,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
