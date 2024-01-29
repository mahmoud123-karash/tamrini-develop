import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/drawer_list_tile_widget.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_states.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/views/store_owner_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../../core/shared/components.dart';
import '../../../../order/presentation/views/orders_screen.dart';
import '../../../../store/presentation/views/new_store_screen.dart';
import 'badge_order_icon_widget.dart';

class StoreOwnerWidget extends StatelessWidget {
  const StoreOwnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return Column(
      children: [
        DrawerListTileWidget(
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
        ),
        BlocBuilder<OrderCubit, OrderStates>(
          builder: (context, state) {
            if (state is SuccessGetOrdersState) {
              return Row(
                children: [
                  Expanded(
                    child: DrawerListTileWidget(
                      onPressed: () {
                        navigateTo(context, const OrdersScreen());
                      },
                      icon: Icons.shopping_bag_outlined,
                      lable: S.of(context).orders,
                    ),
                  ),
                  BadgeOrderIconWidget(
                    length: state.list
                        .where((element) => element.status == 'waiting')
                        .length,
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
