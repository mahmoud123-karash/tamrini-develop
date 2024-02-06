import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/ban_gym_container_widget.dart';
import 'package:tamrini/features/navBar/presentation/views/widgets/badge_order_icon_widget.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_states.dart';
import 'package:tamrini/features/order/presentation/views/orders_screen.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/features/store/presentation/views/store_owner_products_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/store_cubit/store_cubit.dart';
import 'widgets/store_cover_image_widget.dart';
import 'widgets/store_onwer_buttons_row_widget.dart';
import 'widgets/store_owner_list_tile_widget.dart';

class StoreOwnerScreen extends StatelessWidget {
  const StoreOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    final EdgeInsets systemPadding = MediaQuery.of(context).padding;

    return Scaffold(
      body: BlocBuilder<StoreCubit, StoreStates>(
        builder: (context, state) {
          StoreModel model = StoreCubit.get(context).getStore(uid).first;
          return Column(
            children: [
              SizedBox(
                height: systemPadding.top + systemPadding.bottom,
              ),
              StoreCoverImageWidget(
                isBanned: model.isBanned,
                name: model.name,
                contact: model.contact,
                uid: model.storeOwnerUid,
                image: model.image,
                num: model.products!.length,
              ),
              if (model.isBanned == true)
                BanGymContainerWidget(message: S.of(context).ban_store_hint),
              StoreOwnerButtonsRowWidget(
                model: model,
              ),
              const SizedBox(
                height: 10,
              ),
              StoreOwnerListTileWidget(
                onTap: () {
                  navigateTo(context, StoreOwnerProductScreen(uid: uid));
                },
                icon: Icons.storage,
                lable: S.of(context).store_owner_products,
              ),
              const SizedBox(
                height: 10,
              ),
              StoreOwnerListTileWidget(
                onTap: () {},
                icon: Icons.attach_money_rounded,
                lable: S.of(context).profits,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<OrderCubit, OrderStates>(
                builder: (context, state) {
                  if (state is SuccessGetOrdersState) {
                    return Row(
                      children: [
                        Expanded(
                          child: StoreOwnerListTileWidget(
                            onTap: () {
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
        },
      ),
    );
  }
}
