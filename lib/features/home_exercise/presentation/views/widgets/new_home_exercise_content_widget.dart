import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/video_manager.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/section_image_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class NewHomeExerciseContentWidget extends StatelessWidget {
  const NewHomeExerciseContentWidget({
    super.key,
    required this.nameController,
    required this.autovalidateMode,
    required this.formKey,
    required this.image,
    required this.descriptionController,
    required this.youtubController,
    required this.isUri,
    required this.vedioUri,
  });
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController youtubController;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;
  final String image;
  final bool isUri;
  final String vedioUri;

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
                    ImageCubit.get(context).videoFromGallery();
                  },
                ),
              const SizedBox(
                height: 20,
              ),
              addTextField(
                lable: S.of(context).exercise_name,
                controller: nameController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              const SizedBox(
                height: 20,
              ),
              addTextField(
                lable: S.of(context).exercise_description,
                controller: descriptionController,
                keyboardType: TextInputType.text,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              VideoManager(
                remote_url: vedioUri,
              ),
              const SizedBox(
                height: 20,
              ),
              if (isUri)
                addTextField(
                  lable: S.of(context).youtub_uri,
                  controller: youtubController,
                  keyboardType: TextInputType.url,
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
