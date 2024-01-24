import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/section_image_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class AddSectionContentWidget extends StatelessWidget {
  const AddSectionContentWidget({
    super.key,
    required this.nameController,
    required this.orderController,
    required this.autovalidateMode,
    required this.formKey,
  });
  final TextEditingController nameController;
  final TextEditingController orderController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SectionImageWidget(
              image: '',
            ),
            const SizedBox(
              height: 25,
            ),
            addTextField(
              lable: S.of(context).section_name,
              controller: nameController,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 20,
            ),
            addTextField(
              lable: S.of(context).section_order,
              controller: orderController,
              keyboardType: TextInputType.number,
              context: context,
              autovalidateMode: autovalidateMode,
            ),
            const SizedBox(
              height: 20,
            ),
            addFromGalleryItems(
              title: S.of(context).add_images,
              icon: Icons.add_a_photo_outlined,
              function: () {
                ImageCubit.get(context).pickImage();
              },
            )
          ],
        ),
      ),
    );
  }
}
