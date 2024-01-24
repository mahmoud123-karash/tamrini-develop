import 'package:flutter/material.dart';

import '../../../../../core/shared/components.dart';

class SectionIamgeStackWidget extends StatelessWidget {
  const SectionIamgeStackWidget(
      {super.key,
      required this.imageProvider,
      required this.onClose,
      this.isEdit = false});
  final ImageProvider<Object> imageProvider;
  final VoidCallback onClose;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        imageViewWidget(
          height: height / 4,
          width: width / 1.2,
          imageProvider: imageProvider,
        ),
        if (!isEdit)
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: onClose,
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
