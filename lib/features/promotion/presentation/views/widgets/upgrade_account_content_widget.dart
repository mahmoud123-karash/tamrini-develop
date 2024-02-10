import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/lists.dart';
import 'package:tamrini/features/promotion/presentation/manager/promotion_cubit/promotion_cubit.dart';
import 'package:tamrini/features/promotion/presentation/views/widgets/promotion_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class UpgradeAccountContentWidget extends StatelessWidget {
  const UpgradeAccountContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.separated(
        itemBuilder: (context, index) => PromotiomItemWidget(
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
              title: promotionList(context)[index],
              desc: S.of(context).promotion_request_question,
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                PromotionCubit.get(context).requestpromotion(
                  promotionType: promotionList(context)[index],
                );
              },
            ).show();
          },
          lable: promotionList(context)[index],
          icon: icons[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: 4,
      ),
    );
  }
}
