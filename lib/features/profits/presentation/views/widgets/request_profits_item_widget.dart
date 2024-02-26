import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'request_profits_colum_widget.dart';

class RequestProfitsItemWidget extends StatelessWidget {
  const RequestProfitsItemWidget({super.key, required this.model});
  final ProfitsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: model.status == 'wating'
            ? appColor.withOpacity(0.3)
            : greyColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              '${model.amount} ${S.of(context).dinar}',
              style: TextStyles.style15.copyWith(
                color: appColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            RequestProfitsColumWidget(
              cashNum: model.cashNumber,
              date: DateFormat('EEE, M/d/y', 'en').format(
                model.requestedAt.toDate(),
              ),
              status: model.status,
            )
          ],
        ),
      ),
    );
  }
}
