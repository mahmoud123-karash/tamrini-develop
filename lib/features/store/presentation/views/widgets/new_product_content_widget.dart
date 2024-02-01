import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/section_image_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_add_text_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_type_list_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'add_product_price_widget.dart';
import 'available_checkbox_widget.dart';
import 'best_seller_checkbox_widget.dart';

class NewProductContentWidget extends StatelessWidget {
  const NewProductContentWidget({
    super.key,
    required this.nameController,
    required this.autovalidateMode,
    required this.formKey,
    required this.image,
    required this.descriptionController,
    required this.priceController,
    required this.oldPriceController,
    required this.isEdit,
  });
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController oldPriceController;

  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;
  final String image;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SectionImageWidget(
                image: image,
              ),
              const SizedBox(
                height: 20,
              ),
              if (ImageCubit.get(context).paths.isEmpty)
                addFromGalleryItems(
                  title: image != ''
                      ? S.of(context).change_image
                      : S.of(context).add_image,
                  icon: Icons.add_a_photo_outlined,
                  function: () {
                    ImageCubit.get(context).pickImage();
                  },
                ),
              const SizedBox(
                height: 20,
              ),
              addTextField(
                lable: S.of(context).product_name,
                controller: nameController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              const SizedBox(
                height: 20,
              ),
              addTextField(
                lable: S.of(context).product_description,
                controller: descriptionController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              AddProductPriceWidget(
                priceController: priceController,
                oldPriceController: oldPriceController,
                autovalidateMode: autovalidateMode,
              ),
              const SizedBox(
                height: 20,
              ),
              ProductAddTextWidget(text: S.of(context).product_type),
              const ProductTypeListViewBuilderWidget(),
              if (isEdit) const AvailableCheckboxWidget(),
              const BestSellerCheckboxWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
