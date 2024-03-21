import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/distripute_assets.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/views/supplement_article_details_screen.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';

class SupplementItemWidget extends StatelessWidget {
  const SupplementItemWidget({super.key, required this.supplementId});
  final String supplementId;

  @override
  Widget build(BuildContext context) {
    SupplementData model =
        SupplementCubit.get(context).getSupplementData(supplementId)!;

    List<Widget> asstest = [];
    asstest = distributeAssets(
      model.images,
      fit: BoxFit.contain,
    );
    var width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        InkWell(
          onTap: () {
            navigateTo(
              context,
              SupplementArticlesDetailsScreen(
                id: supplementId,
                categoryId: '',
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: ThemeCubit.get(context).themeColor.withOpacity(0.3),
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
                            width: width / 1.5,
                            height: 220,
                            child: ImageSlideshow(
                              children: asstest,
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10),
                    child: SizedBox(
                      width: width / 1.5,
                      child: Text(
                        model.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: IconButton(
            onPressed: () {
              CourseCubit.get(context).removeSupplement(
                supplementId: supplementId,
              );
            },
            icon: const Icon(
              Icons.close_outlined,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
