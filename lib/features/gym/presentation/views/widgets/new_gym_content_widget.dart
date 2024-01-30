import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/new_gym_images_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'locate_gym_custom_button_widget.dart';

class NewGymContentWidget extends StatelessWidget {
  const NewGymContentWidget({
    super.key,
    required this.nameController,
    required this.autovalidateMode,
    required this.formKey,
    required this.priceController,
    required this.descriptionController,
  });
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;

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
              const NewGymImagesListViewWidget(),
              addFromGalleryItems(
                title: S.of(context).add_images,
                icon: Icons.add_a_photo_outlined,
                function: () {
                  ImageCubit.get(context).imgsFromGallery();
                },
              ),
              const SizedBox(
                height: 25,
              ),
              addTextField(
                lable: S.of(context).gym_name,
                controller: nameController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              const SizedBox(
                height: 20,
              ),
              addTextField(
                lable: S.of(context).gym_description,
                controller: descriptionController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              const SizedBox(
                height: 20,
              ),
              addTextField(
                lable: S.of(context).price_sub,
                controller: priceController,
                context: context,
                autovalidateMode: autovalidateMode,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              const LocateGymCustomButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
