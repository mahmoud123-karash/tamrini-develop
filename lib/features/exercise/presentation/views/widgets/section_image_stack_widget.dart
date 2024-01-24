import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';

import '../../../../../core/shared/components.dart';

class SectionIamgeStackWidget extends StatelessWidget {
  const SectionIamgeStackWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        imageViewWidget(
          height: height / 4,
          width: width / 1.2,
          imageProvider: FileImage(
            File(image),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                ImageCubit.get(context).removeImage(path: image);
              },
              child: const Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
