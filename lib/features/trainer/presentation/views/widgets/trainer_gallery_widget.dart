import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/achievement_model.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_gallery_screen.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/title_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerGalleryWidget extends StatelessWidget {
  const TrainerGalleryWidget({super.key, required this.gallery});
  final List<AchivevementModel> gallery;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleTextWidget(lable: S.of(context).trainer_gallery),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton(
            onPressed: () {
              navigateTo(context, TrainerGallerySreen(gallery: gallery));
            },
            child: Text(S.of(context).more),
          ),
        ),
      ],
    );
  }
}
