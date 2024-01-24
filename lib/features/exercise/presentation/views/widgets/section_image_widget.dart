import 'dart:io';

import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';

import 'section_image_stack_widget.dart';

class SectionImageWidget extends StatelessWidget {
  const SectionImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) {
        List<String> paths = ImageCubit.get(context).paths;
        if (state is SucessPickImageState) {
          return SectionIamgeStackWidget(
            imageProvider: FileImage(File(paths.first)),
            onClose: () {
              ImageCubit.get(context).removeImage(path: paths.first);
            },
          );
        } else {
          return image != ''
              ? SectionIamgeStackWidget(
                  isEdit: true,
                  imageProvider: FirebaseImageProvider(FirebaseUrl(image)),
                  onClose: () {
                    ImageCubit.get(context).pickImage();
                  },
                )
              : Container();
        }
      },
    );
  }
}
