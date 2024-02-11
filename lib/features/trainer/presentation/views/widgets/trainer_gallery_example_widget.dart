import 'package:flutter/material.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

import 'trainer_gallery_item_widget.dart';
import 'trainer_gallery_widget.dart';

class TrainerGalleryExampleWidget extends StatelessWidget {
  const TrainerGalleryExampleWidget({super.key, required this.model});
  final TrainerModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TrainerGalleryWidget(model: model),
        TrainerGalleryItemWidget(
          model: model.gallery.first,
          trainer: model,
          isExample: true,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
