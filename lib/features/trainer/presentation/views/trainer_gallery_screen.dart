import 'package:flutter/material.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/achievement_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/trainer_gallery_item_widget.dart';

class TrainerGallerySreen extends StatelessWidget {
  const TrainerGallerySreen({super.key, required this.gallery});
  final List<AchivevementModel> gallery;

  @override
  Widget build(BuildContext context) {
    gallery.sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).trainer_gallery),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) => TrainerGalleryItemWidget(
            imageBefore: gallery[index].before,
            imageAfter: gallery[index].after,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: gallery.length,
        ),
      ),
    );
  }
}
