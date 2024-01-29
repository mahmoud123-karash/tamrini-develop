import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';

import 'gym_distance_widget.dart';
import 'gym_name_and_price_widget.dart';
import 'gym_slide_show_images_widget.dart';

class GymDetailsContentWidget extends StatelessWidget {
  const GymDetailsContentWidget({super.key, required this.model});
  final GymModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GymNameAndPriceWidget(
            name: model.name,
            price: model.price.toString(),
          ),
          const SizedBox(
            height: 10,
          ),
          model.assets.isEmpty
              ? Container()
              : GymSlideShowImagesWidget(
                  assets: model.assets,
                  name: model.name,
                ),
          const SizedBox(
            height: 10,
          ),
          GymDistanceWidget(distance: model.distance),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                (model.description),
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}
