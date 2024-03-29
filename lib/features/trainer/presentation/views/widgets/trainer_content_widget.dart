import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/ban_gym_container_widget.dart';
import 'package:tamrini/features/profits/presentation/views/profits_screen.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_gallery_example_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_name_image_location_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_row_info_widget.dart';

import '../../../../../generated/l10n.dart';
import 'rating_trainer_builder_widget.dart';
import 'title_text_widget.dart';
import 'trainer_buttons_row_widget.dart';
import 'trainer_social_medial_widget.dart';
import 'trainer_working_hour_widget.dart';
import 'trainner_description_widget.dart';

class TrainerContentWidget extends StatelessWidget {
  const TrainerContentWidget({super.key, required this.trainer});
  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    String trainerId = CacheHelper.getData(key: 'trainerId') ?? '';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (trainer.isBanned && userType == UserType.trainer)
            BanGymContainerWidget(message: S.of(context).ban_title_trainer),
          if (trainer.isBanned && userType == UserType.admin)
            banWidget(lable: S.of(context).ban_hint_admin),
          const SizedBox(
            height: 10,
          ),
          if (trainer.isBanned == false)
            if (trainer.uid == uid && userType == UserType.trainer)
              TrainerButtonsRowWidget(trainerId: trainer.uid),
          if (trainer.isBanned == false)
            if (trainer.uid == uid && userType == UserType.trainer)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: addCustomButton(
                  icon: Icons.attach_money,
                  onPressed: () {
                    navigateTo(
                      context,
                      ProfitsScreen(profits: trainer.profits, id: trainer.uid),
                    );
                  },
                  lable: S.of(context).profits,
                ),
              ),
          const SizedBox(
            height: 10,
          ),
          if (trainer.uid == trainerId)
            RatingTrainerBuilderWidget(trainerId: trainer.uid),
          const SizedBox(
            height: 15,
          ),
          TrainerNameLoactionImageWidget(
            address: trainer.user!.address,
            name: trainer.user!.name,
            image: trainer.user!.image,
            uid: trainer.user!.uid,
          ),
          const Divider(
            height: 50,
            endIndent: 20,
            indent: 20,
          ),
          TrainerRowInfoWIdget(trainer: trainer),
          const SizedBox(
            height: 40,
          ),
          TitleTextWidget(lable: S.of(context).media),
          const SizedBox(
            height: 25,
          ),
          TrainerSocialMediaWidget(
            user: trainer.user!,
          ),
          if (trainer.description != '')
            TarinerDescriptionWidget(
              description: trainer.description,
            ),
          const SizedBox(
            height: 20,
          ),
          if (trainer.fromH != '')
            TrainerWorkingHourWidget(
              from: trainer.fromH,
              to: trainer.toH,
            ),
          if (trainer.fromH != '')
            const SizedBox(
              height: 50,
            ),
          if (trainer.gallery.isNotEmpty)
            TrainerGalleryExampleWidget(model: trainer),
        ],
      ),
    );
  }
}
