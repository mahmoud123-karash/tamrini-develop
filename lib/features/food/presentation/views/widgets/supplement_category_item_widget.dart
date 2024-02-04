import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/presentation/views/new_category_screen.dart';
import 'package:tamrini/features/food/presentation/views/supplement_category_articles_screen.dart';

import 'remove_category_custom_button_widget.dart';

class SupplementCategoryItemWidget extends StatelessWidget {
  const SupplementCategoryItemWidget({super.key, required this.model});
  final SupplementModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context,
            SupplementArticlesScreen(list: model.data, title: model.title));
      },
      child: Container(
        alignment: Alignment.topRight,
        constraints: BoxConstraints(
          minHeight: 100.h,
          minWidth: 100.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            colorFilter:
                const ColorFilter.mode(Colors.black45, BlendMode.darken),
            image: model.image != ''
                ? FirebaseImageProvider(
                    FirebaseUrl(model.image),
                  )
                : const AssetImage(Assets.imagesArticalesBanner)
                    as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RemoveCategoryCustomButtonWidget(model: model),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 105.w,
                    ),
                    child: AutoSizeText(
                      model.title,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, NewCategoryScreen(model: model));
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
