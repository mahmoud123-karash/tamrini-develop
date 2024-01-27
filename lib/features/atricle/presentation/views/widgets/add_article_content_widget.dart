import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/section_image_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class AddArticleContentWidget extends StatelessWidget {
  const AddArticleContentWidget({
    super.key,
    required this.nameController,
    required this.articleController,
    required this.autovalidateMode,
    required this.formKey,
    required this.image,
  });
  final TextEditingController nameController;
  final TextEditingController articleController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;
  final String image;

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
                height: 25,
              ),
              addTextField(
                lable: S.of(context).article_name,
                controller: nameController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              const SizedBox(
                height: 20,
              ),
              addTextField(
                lable: S.of(context).article_body,
                controller: articleController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
