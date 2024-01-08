import 'package:flutter/material.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/achievement_model.dart';

import 'trainer_gallery_item_widget.dart';
import 'trainer_gallery_widget.dart';

class TrainerGalleryExampleWidget extends StatelessWidget {
  const TrainerGalleryExampleWidget({super.key, required this.gallery});
  final List<AchivevementModel> gallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TrainerGalleryWidget(gallery: gallery),
        TrainerGalleryItemWidget(
          imageBefore: gallery.first.before,
          imageAfter: gallery.first.after,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
