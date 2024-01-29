import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveProductIconWidget extends StatelessWidget {
  const RemoveProductIconWidget({
    super.key,
    required this.store,
    required this.model,
  });
  final StoreModel store;
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: CircleAvatar(
        backgroundColor: Colors.red.withOpacity(0.2),
        child: IconButton(
          onPressed: () {
            AwesomeDialog(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              showCloseIcon: true,
              titleTextStyle: TextStyles.style17.copyWith(
                fontWeight: FontWeight.bold,
                color: appColor,
              ),
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.bottomSlide,
              title: model.title,
              desc: S.of(context).remove_product_q,
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                StoreCubit.get(context).removeProduct(
                  store: store,
                  oldModel: model,
                  context: context,
                );
              },
            ).show();
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
