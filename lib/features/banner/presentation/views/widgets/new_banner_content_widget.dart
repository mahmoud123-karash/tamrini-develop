import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/section_image_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class NewBannerContentWidget extends StatelessWidget {
  const NewBannerContentWidget({
    super.key,
    required this.uriController,
    required this.autovalidateMode,
    required this.formKey,
  });

  final TextEditingController uriController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const SectionImageWidget(
            image: '',
          ),
          const SizedBox(
            height: 20,
          ),
          addTextField(
            lable: S.of(context).banner_uri,
            controller: uriController,
            context: context,
            autovalidateMode: autovalidateMode,
          ),
          const SizedBox(
            height: 10,
          ),
          if (ImageCubit.get(context).paths.isEmpty)
            addFromGalleryItems(
              title: S.of(context).add_image,
              icon: Icons.add_a_photo_outlined,
              function: () {
                ImageCubit.get(context).pickImage();
              },
            ),
        ],
      ),
    );
  }
}
