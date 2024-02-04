import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';

import 'supplement_image_slide_show_widget.dart';

class SupplementSetailsContentWidget extends StatelessWidget {
  const SupplementSetailsContentWidget({super.key, required this.model});
  final SupplementData model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          model.images.isEmpty
              ? Container()
              : SupplementImageSlideShowWidget(
                  images: model.images,
                  title: model.title,
                ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Padding(
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
          ),
        ],
      ),
    );
  }
}
