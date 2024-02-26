import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

import 'profits_row_info_widget.dart';

class ProfitsColumProfitsWidget extends StatelessWidget {
  const ProfitsColumProfitsWidget({
    super.key,
    required this.availableProfits,
    required this.totalProfits,
  });
  final num availableProfits;
  final num totalProfits;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              S.of(context).profits,
              style: TextStyles.style14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.attach_money,
              size: 50,
              color: Colors.amber,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        ProfitsRowInfoWidget(
          lable: S.of(context).total_profits,
          value: totalProfits.toString(),
        ),
        const SizedBox(
          height: 10,
        ),
        ProfitsRowInfoWidget(
          lable: S.of(context).avaliabe_profits,
          value: availableProfits.toString(),
        ),
        const SizedBox(
          height: 10,
        ),
        ProfitsRowInfoWidget(
          lable: S.of(context).pendding_profits,
          value: (totalProfits - availableProfits).toString(),
        )
      ],
    );
  }
}
