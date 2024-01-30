import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/image_item_widget.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/text_images_new_gym_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class NewImagesListViewWidget extends StatelessWidget {
  const NewImagesListViewWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) {
        List<String> paths = ImageCubit.get(context).paths;
        return paths.isEmpty
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextImagesNewGymWidget(
                    lable: S.of(context).new_images,
                  ),
                  SizedBox(
                    height: height / 4,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ImageItemWidget(
                        imageProvider: FileImage(
                          File(paths[index]),
                        ),
                        onClose: () {
                          ImageCubit.get(context)
                              .removeImage(path: paths[index]);
                        },
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                      itemCount: paths.length,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
