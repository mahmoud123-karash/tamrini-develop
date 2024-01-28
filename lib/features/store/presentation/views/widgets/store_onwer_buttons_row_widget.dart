import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/new_product_screen.dart';
import 'package:tamrini/features/store/presentation/views/new_store_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class StoreOwnerButtonsRowWidget extends StatelessWidget {
  const StoreOwnerButtonsRowWidget({super.key, required this.model});
  final StoreModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: addCustomButton(
              icon: Icons.edit,
              lable: S.of(context).edit_store,
              fontSize: 15,
              onPressed: () {
                navigateTo(context, NewStoreScreen(model: model));
              },
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: addCustomButton(
              fontSize: 15,
              lable: S.of(context).add_product,
              onPressed: () {
                navigateTo(context, const NewProductScreen());
              },
            ),
          )
        ],
      ),
    );
  }
}
