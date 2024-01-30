import 'package:flutter/material.dart';

import 'package:tamrini/features/gym/presentation/views/widgets/new_images_list_view_widget.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/old_images_list_view_widget.dart';

class NewGymImagesListViewWidget extends StatelessWidget {
  const NewGymImagesListViewWidget({super.key, required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NewImagesListViewWidget(
          height: height,
        ),
        OldImagesListViewWidget(height: height, images: images),
      ],
    );
  }
}
