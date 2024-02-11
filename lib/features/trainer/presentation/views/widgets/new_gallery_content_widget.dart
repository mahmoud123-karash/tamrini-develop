import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/section_image_stack_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/name_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class NewGalleryContentWidget extends StatelessWidget {
  const NewGalleryContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) {
        List<String> paths = ImageCubit.get(context).paths;
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameTextWidget(text: S.of(context).image_before),
              const SizedBox(
                height: 5,
              ),
              if (paths.isNotEmpty)
                ImageWidgetBuilder(
                  imgPath: paths.first,
                  onPressed: () {
                    ImageCubit.get(context).clearPaths();
                  },
                ),
              if (paths.isEmpty) const PickImagecustomWidget(),
              const SizedBox(
                height: 15,
              ),
              if (paths.isNotEmpty)
                NameTextWidget(text: S.of(context).image_after),
              const SizedBox(
                height: 5,
              ),
              if (paths.length >= 2)
                ImageWidgetBuilder(
                  imgPath: paths[1],
                  onPressed: () {
                    ImageCubit.get(context).removeImage(path: paths[1]);
                  },
                ),
              if (paths.isNotEmpty) const PickImagecustomWidget(),
            ],
          ),
        );
      },
    );
  }
}

class ImageWidgetBuilder extends StatelessWidget {
  const ImageWidgetBuilder({
    super.key,
    required this.imgPath,
    required this.onPressed,
  });
  final String imgPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) {
        return Center(
          child: SectionIamgeStackWidget(
            imageProvider: FileImage(
              File(imgPath),
            ),
            onClose: onPressed,
          ),
        );
      },
    );
  }
}

class PickImagecustomWidget extends StatelessWidget {
  const PickImagecustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          ImageCubit.get(context).pickImage();
        },
        child: Text(
          S.of(context).add_image,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
