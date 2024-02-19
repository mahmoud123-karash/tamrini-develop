import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/features/food/presentation/views/new_category_screen.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_grid_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementsCategoryScreen extends StatelessWidget {
  const SupplementsCategoryScreen({Key? key, required this.isCourse})
      : super(key: key);
  final bool isCourse;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      appBar: myAppBar(S.of(context).nuttritions),
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          if (userType == 'admin')
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: addCustomButton(
                onPressed: () {
                  navigateTo(context, const NewCategoryScreen());
                },
                lable: S.of(context).add_nutrition_classification,
              ),
            ),
          Expanded(
            child: SupplementGridViewBuilderWidget(isCourse: isCourse),
          ),
        ],
      ),
    );
  }
}
