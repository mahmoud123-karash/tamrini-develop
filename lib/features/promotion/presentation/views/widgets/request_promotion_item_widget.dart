import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/promotion/presentation/views/widgets/promotion_name_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'promotion_type_row_widget.dart';

class RequestPromotiomItemWidget extends StatelessWidget {
  const RequestPromotiomItemWidget({
    super.key,
    required this.onPressed,
    required this.lable,
    required this.icon,
  });
  final VoidCallback onPressed;
  final String lable;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PromotionNameRowWidget(),
            const SizedBox(
              height: 10,
            ),
            PromotionTypeRowWidget(lable: lable, icon: icon),
            const SizedBox(
              height: 20,
            ),
            customButton(
              onPressed: onPressed,
              lable: S.of(context).promotion_request,
              color: Colors.amber.withOpacity(0.7),
            )
          ],
        ),
      ),
    );
  }
}
