import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/views/diet_food_details_screen.dart';

import 'diet_food_name_and_date_widget.dart';
import 'diet_food_slide_image_widget.dart';
import 'remove_diet_food_widget.dart';

class DietFoodItemWidget extends StatelessWidget {
  const DietFoodItemWidget({super.key, required this.model});
  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, DietFoodDetailsScreen(id: model.id));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (model.assets.isNotEmpty)
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      DietFoodSlideImageWidget(
                        images: model.assets,
                        title: model.title,
                        isNavigate: false,
                      ),
                      RemoveDietFoodWidget(model: model),
                    ],
                  ),
                const SizedBox(
                  height: 5,
                ),
                DietFoodNameAndDateWidget(
                  name: model.title,
                  date: model.date,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      model.description,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
