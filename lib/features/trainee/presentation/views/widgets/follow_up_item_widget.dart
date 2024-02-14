import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';

import '../../../../gym/presentation/views/widgets/gym_slide_show_images_widget.dart';
import '../follow_details_screen.dart';

class FollowUpItemWidget extends StatelessWidget {
  const FollowUpItemWidget({super.key, required this.model});
  final FollowUpModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, FollowDetailsScreen(model: model));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColor.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEE, M/d/y').format(model.createdAt.toDate()),
                style: TextStyles.style14.copyWith(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GymSlideShowImagesWidget(
                  isNavige: false,
                  assets: model.images,
                  name: DateFormat('EEE, M/d/y').format(
                    model.createdAt.toDate(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
