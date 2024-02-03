import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_name_and_date_widget.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_slide_image_widget.dart';

class DietFoodContentWidget extends StatelessWidget {
  const DietFoodContentWidget({super.key, required this.model});
  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
