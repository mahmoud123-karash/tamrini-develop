import 'package:flutter/material.dart';
import 'package:tamrini/features/order/presentation/views/widgets/input_address_field_widget.dart';
import 'package:tamrini/features/order/presentation/views/widgets/product_container_widget.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/generated/l10n.dart';

class AddressContentWidget extends StatelessWidget {
  const AddressContentWidget({
    super.key,
    required this.model,
    required this.autovalidateMode,
    required this.nameController,
    required this.phoneController,
    required this.areaController,
    required this.cityController,
    required this.amount,
    required this.formKey,
  });
  final ProductModel model;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController areaController;
  final TextEditingController cityController;

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ProductContainerWidget(
              name: model.title,
              price: model.price,
              image: model.image,
              amount: amount,
            ),
            const SizedBox(
              height: 30,
            ),
            InputAddressFieldWidget(
              controller: nameController,
              lable: S.of(context).full_name,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 20,
            ),
            InputAddressFieldWidget(
              controller: phoneController,
              lable: S.of(context).phone,
              textInputType: TextInputType.number,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 20,
            ),
            InputAddressFieldWidget(
              controller: cityController,
              lable: S.of(context).city,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 20,
            ),
            InputAddressFieldWidget(
              controller: areaController,
              lable: S.of(context).area,
              autovalidateMode: autovalidateMode,
            ),
          ],
        ),
      ),
    );
  }
}
