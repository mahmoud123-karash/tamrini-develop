import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_gallery_screen.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/title_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerGalleryWidget extends StatelessWidget {
  const TrainerGalleryWidget({super.key, required this.model});
  final TrainerModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleTextWidget(lable: S.of(context).trainer_gallery),
        const Spacer(),
        TextButton(
          onPressed: () {
            if (model.isBanned == false) {
              navigateTo(
                context,
                TrainerGallerySreen(id: model.uid),
              );
            }
          },
          child: Text(S.of(context).more),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
