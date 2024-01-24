import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';

import '../../../../../core/shared/components.dart';
import 'section_image_stack_widget.dart';

class SectionImageWidget extends StatelessWidget {
  const SectionImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) {
        List<String> paths = ImageCubit.get(context).paths;
        if (state is SucessPickImageState) {
          return SectionIamgeStackWidget(image: paths.first);
        } else {
          return image != ''
              ? imageViewWidget(
                  height: height / 4,
                  width: width / 1.5,
                  imageProvider: FirebaseImageProvider(
                    FirebaseUrl(image),
                  ),
                )
              : Container();
        }
      },
    );
  }
}
