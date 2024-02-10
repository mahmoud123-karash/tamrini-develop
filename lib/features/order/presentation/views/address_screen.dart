import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/presentation/manager/address_cubit/address_states.dart';
import 'package:tamrini/features/order/presentation/views/widgets/address_content_widget.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/address_cubit/address_cubit.dart';
import 'summary_order_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.model});
  final ProductModel model;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    houseController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(),
      child: Scaffold(
        appBar: myAppBar(S.of(context).buyNow),
        body: BlocBuilder<AddressCubit, AddressStates>(
          builder: (context, state) {
            int amount = AddressCubit.get(context).amount;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AddressContentWidget(
                    formKey: formkey,
                    model: widget.model,
                    autovalidateMode: autovalidateMode,
                    nameController: nameController,
                    phoneController: phoneController,
                    houseController: houseController,
                    areaController: areaController,
                    pincodeController: pincodeController,
                    cityController: cityController,
                    amount: amount,
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: customButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            navigateTo(
                              context,
                              SummaryOrderScreen(
                                storeId: widget.model.ownerUid,
                                model: Product(
                                  title: widget.model.title,
                                  image: widget.model.image,
                                  id: widget.model.id,
                                  price: widget.model.price.toInt(),
                                  quantity: AddressCubit.get(context).amount,
                                ),
                                name: nameController.text,
                                phone: phoneController.text,
                                address:
                                    '${cityController.text},${areaController.text},${houseController.text},${pincodeController.text}',
                              ),
                            );
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                        lable: S.of(context).payment,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}