import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/writer_row_widget.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_name_and_date_widget.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_slide_image_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class DietFoodContentWidget extends StatelessWidget {
  const DietFoodContentWidget({super.key, required this.model});
  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (model.writerUid == uid && model.isRefused == true)
            banWidget(lable: S.of(context).ban_food_hint),
          DietFoodNameAndDateWidget(
            name: model.title,
            date: model.date,
          ),
          const SizedBox(
            height: 5,
          ),
          model.assets.isEmpty
              ? Container()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: DietFoodSlideImageWidget(
                    images: model.assets,
                    title: model.title,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                (model.description),
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
          if (model.writerUid != uid) WriterWidget(model: model)
        ],
      ),
    );
  }
}

class WriterWidget extends StatelessWidget {
  const WriterWidget({
    super.key,
    required this.model,
  });

  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(
          height: 5,
        ),
        WriterRowWidget(
          model: model.user!,
        ),
      ],
    );
  }
}
