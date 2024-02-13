import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/custom_image_slide_show.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';

class FollowUpItemWidget extends StatelessWidget {
  const FollowUpItemWidget({super.key, required this.model});
  final FollowUpModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                height: 5,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomImageSlideShow(
                  height: 150,
                  assets: model.images,
                  children: distributeAssets(model.images),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
