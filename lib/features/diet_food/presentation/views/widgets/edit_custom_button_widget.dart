import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/views/new_diet_food_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class EditCustomButtonWidget extends StatelessWidget {
  const EditCustomButtonWidget({super.key, required this.model});
  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    String userType = CacheHelper.getData(key: 'usertype');

    return userType == 'admin' || userType == 'writer'
        ? model.writerUid == uid
            ? customButton(
                onPressed: () {
                  navigateTo(context, NewDietFoodScreen(model: model));
                },
                lable: S.of(context).edit_meal,
              )
            : Container()
        : Container();
  }
}
