import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveDietFoodWidget extends StatelessWidget {
  const RemoveDietFoodWidget({super.key, required this.model});
  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');

    return Column(
      children: [
        if (userType == UserType.admin) RemoveWidget(model: model),
        if (userType == UserType.writer && model.writerUid == uid)
          RemoveWidget(model: model),
      ],
    );
  }
}

class RemoveWidget extends StatelessWidget {
  const RemoveWidget({
    super.key,
    required this.model,
  });

  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        AwesomeDialog(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          showCloseIcon: true,
          titleTextStyle: TextStyles.style17.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          title: model.title,
          desc: S.of(context).q_remove_article,
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            DietFoodCubit.get(context).removeMeal(
              assets: model.assets,
              id: model.id,
              context: context,
            );
          },
        ).show();
      },
      icon: const Icon(Icons.delete_forever),
      color: Colors.red,
    );
  }
}
