import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/questions/presentation/views/diet_food_details_screen.dart';

import 'diet_food_slide_image_widget.dart';

class DietFoodItemWidget extends StatelessWidget {
  const DietFoodItemWidget({super.key, required this.model});
  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, DietFoodDetailsScreen(model: model));
        },
        child: Stack(
          children: [
            Card(
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
                      DietFoodSlideImageWidget(
                          images: model.assets, title: model.title),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  model.title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            model.date != Timestamp.now()
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AutoSizeText(
                                        DateFormat('yyyy-MM-dd').format(
                                            DateTime.parse(model.date
                                                .toDate()
                                                .toString())),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
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
          ],
        ),
      ),
    );
  }
}
