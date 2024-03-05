import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/build_store_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/store_cubit/store_cubit.dart';
import 'widgets/new_product_content_widget.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key, this.model});
  final ProductModel? model;

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController oldPriceController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late StoreCubit cubit;

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    cubit = StoreCubit.get(context);
    if (widget.model != null) {
      nameController.text = widget.model!.title;
      descriptionController.text = widget.model!.description;
      priceController.text = widget.model!.price.toString();
      oldPriceController.text = widget.model!.oldPrice.toString();
      cubit.isSale = widget.model!.oldPrice != 0.0;
      cubit.isBestSeller = widget.model!.bestSeller;
      cubit.available = widget.model!.available;
      cubit.productType = widget.model!.type;
    } else {
      cubit.isSale = false;
      cubit.isBestSeller = false;
      cubit.available = false;
      cubit.productType = '';
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    oldPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return Scaffold(
      appBar: myAppBar(
        widget.model != null
            ? S.of(context).edit_product
            : S.of(context).add_product,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NewProductContentWidget(
              nameController: nameController,
              descriptionController: descriptionController,
              oldPriceController: oldPriceController,
              priceController: priceController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model != null ? widget.model!.image : "",
              isEdit: widget.model != null,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: StoreCustomButtonBuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit
                    : S.of(context).add,
                onPressed: () {
                  StoreModel store =
                      StoreCubit.get(context).getStore(uid).first;
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                      checkIsSale(
                        cubit,
                        context,
                        () {
                          if (cubit.productType == '') {
                            showSnackBar(
                                context, S.of(context).product_type_hint);
                          } else {
                            if (int.parse(priceController.text) == 0) {
                              showSnackBar(
                                  context, S.of(context).price_cant_be_zero);
                            } else {
                              cubit.editProduct(
                                oldModel: widget.model!,
                                title: nameController.text,
                                description: descriptionController.text,
                                price: int.parse(priceController.text),
                                oldPrice: cubit.isSale
                                    ? int.parse(oldPriceController.text)
                                    : 0,
                                imagePath: paths.isEmpty ? '' : paths.first,
                                store: store,
                                context: context,
                              );
                            }
                          }
                        },
                      );
                    } else {
                      if (paths.isNotEmpty) {
                        checkIsSale(cubit, context, () {
                          if (cubit.productType == '') {
                            showSnackBar(
                                context, S.of(context).product_type_hint);
                          } else {
                            if (int.parse(priceController.text) == 0) {
                              showSnackBar(
                                  context, S.of(context).price_cant_be_zero);
                            } else {
                              cubit.addProduct(
                                title: nameController.text,
                                description: descriptionController.text,
                                price: int.parse(priceController.text),
                                oldPrice: cubit.isSale
                                    ? int.parse(oldPriceController.text)
                                    : 0,
                                imagePath: paths.first,
                                store: store,
                                context: context,
                              );
                            }
                          }
                        });
                      } else {
                        showSnackBar(context, S.of(context).image_error);
                      }
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void checkIsSale(
    StoreCubit cubit,
    BuildContext context,
    VoidCallback function,
  ) {
    if (cubit.isSale) {
      if (int.parse(priceController.text) >=
          int.parse(oldPriceController.text)) {
        showSnackBar(context, S.of(context).oldprice_hint_error);
      } else {
        function();
      }
    } else {
      function();
    }
  }
}
