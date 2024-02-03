import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/manager/article_cubit/diet_food_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class BanCustomButtonWidget extends StatelessWidget {
  const BanCustomButtonWidget({super.key, required this.model});
  final DietFoodModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    String userType = CacheHelper.getData(key: 'usertype');
    return userType == 'admin' && model.writerUid != uid
        ? model.isRefused
            ? banWidget(lable: S.of(context).ban_food_hint)
            : customButton(
                color: Colors.red,
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
                    desc: model.isPending == true
                        ? S.of(context).no_ban_question
                        : S.of(context).ban_question,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      DietFoodCubit.get(context).banFood(
                        id: model.id,
                        isPending: !model.isPending,
                        writerUid: model.writerUid,
                        context: context,
                      );
                    },
                  ).show();
                },
                lable: model.isPending == true
                    ? S.of(context).no_ban
                    : S.of(context).ban,
              )
        : Container();
  }
}
