import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/trainer_options_row_widget.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

class TrainerCourseWidget extends StatelessWidget {
  const TrainerCourseWidget({super.key, required this.model});
  final TrainerModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        CircleAvatar(
          radius: 45,
          backgroundImage: model.user!.image != ''
              ? FirebaseImageProvider(
                  FirebaseUrl(model.user!.image),
                ) as ImageProvider
              : const AssetImage(Assets.imagesProfile),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          model.user!.name,
          style: TextStyles.style16Bold.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TrainerOptionsRowWidget(trainerId: model.uid),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}