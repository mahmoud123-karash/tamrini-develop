import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_store_item_widget.dart';

import '../manager/store_cubit/store_cubit.dart';
import 'widgets/store_cover_image_widget.dart';
import 'widgets/store_onwer_buttons_row_widget.dart';

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
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: systemPadding.top + systemPadding.bottom,
                ),
                StoreCoverImageWidget(
                  name: model.name,
                  contact: model.contact,
                  uid: model.storeOwnerUid,
                  image: model.image,
                  num: model.products!.length,
                ),
                const SizedBox(
                  height: 10,
                ),
                StoreOwnerButtonsRowWidget(
                  model: model,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ProductStoreItemWidget(
                    model: model.products![index],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: model.products!.length,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
