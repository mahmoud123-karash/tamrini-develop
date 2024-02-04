// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';

import '../supplement_article_details_screen.dart';
import 'remove_supplement_custom_button_widget.dart';

class SupplementArticleItemWidget extends StatelessWidget {
  const SupplementArticleItemWidget({
    super.key,
    required this.model,
    required this.categoryId,
  });
  final SupplementData model;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');

    List<Widget> asstest = [];
    asstest = distributeAssets(
      model.images,
      fit: BoxFit.contain,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            SupplementArticlesDetailsScreen(
                id: model.id, categoryId: categoryId),
          );
        },
        child: Stack(
          alignment: Alignment.topLeft,
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
                    model.images.isEmpty
                        ? const SizedBox()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              color: whiteColor,
                              width: double.infinity,
                              child: ImageSlideshow(
                                children: asstest,
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          model.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          model.description,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15.sm,
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
            if (model.writerUid == uid && userType == 'writer')
              RemoveSupplementCustomButtonWidget(
                model: model,
                categoryId: categoryId,
              ),
            if (userType == 'admin')
              RemoveSupplementCustomButtonWidget(
                model: model,
                categoryId: categoryId,
              ),
          ],
        ),
      ),
    );
  }
}
