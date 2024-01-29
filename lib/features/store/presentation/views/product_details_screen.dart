import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/features/store/presentation/views/new_product_screen.dart';
import 'package:tamrini/features/store/presentation/views/store_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'store_owner_screen.dart';
import 'widgets/contact_and_buy_product_widget.dart';
import 'widgets/product_details_content_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.id,
    this.sModel,
  }) : super(key: key);
  final String id;
  final StoreModel? sModel;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHight = mediaQuery.size.height;
    String uid = CacheHelper.getData(key: 'uid');
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).proDetails),
        centerTitle: true,
        actions: [
          if (sModel != null)
            IconButton(
              onPressed: () {
                if (sModel == null) {
                  Navigator.pop(context);
                } else {
                  if (sModel!.storeOwnerUid == uid) {
                    navigateTo(context, const StoreOwnerScreen());
                  } else {
                    navigateTo(context, StoreScreen(model: sModel!));
                  }
                }
              },
              icon: const Icon(
                Ionicons.storefront,
              ),
            )
        ],
      ),
      body: BlocBuilder<StoreCubit, StoreStates>(
        builder: (context, state) {
          ProductModel? model = StoreCubit.get(context).getProduct(id);
          return model == null
              ? Center(
                  child: Text(
                    S.of(context).product_removed,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: double.infinity,
                    height: getHight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            child: ProductDetailsContentWidget(model: model),
                          ),
                        ),
                        model.ownerUid == uid
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: customButton(
                                  onPressed: () {
                                    navigateTo(
                                        context,
                                        NewProductScreen(
                                            model: model, store: sModel!));
                                  },
                                  lable: S.of(context).edit,
                                ),
                              )
                            : ContactAndBuyProductWidget(
                                contact: model.contact,
                              )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
