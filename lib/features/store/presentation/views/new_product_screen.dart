import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/build_store_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

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

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.title;
      descriptionController.text = widget.model!.description;
      priceController.text = widget.model!.price.toString();
      oldPriceController.text = widget.model!.oldPrice.toString();
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
    return Scaffold(
      appBar: myAppBar(
        widget.model != null
            ? S.of(context).edit_store
            : S.of(context).build_store,
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
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                    } else {
                      if (paths.isNotEmpty) {
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
}
