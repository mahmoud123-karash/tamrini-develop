import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/features/profits/presentation/views/widgets/profits_container_widget.dart';
import 'package:tamrini/features/profits/presentation/views/widgets/requests_profits_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'request_profits_container_widget.dart';

class ProfitsContentWidget extends StatelessWidget {
  const ProfitsContentWidget({
    super.key,
    required this.totalProfits,
    required this.id,
    required this.list,
  });

  final num totalProfits;
  final String id;
  final List<ProfitsModel> list;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    num penddingProfits = 0;
    list.where((element) => element.status == 'wating').toList().forEach(
      (element) {
        penddingProfits += element.amount;
      },
    );
    num availableProfits = totalProfits - penddingProfits;
    log(availableProfits.toString());
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfitsContainerWidget(
            availableProfits: availableProfits,
            totalProfits: totalProfits,
          ),
          const SizedBox(
            height: 15,
          ),
          if (availableProfits < 5000)
            Text(
              S.of(context).warning_the_user_profits,
              style: TextStyles.style14.copyWith(
                fontWeight: FontWeight.bold,
                color: appColor,
              ),
              textAlign: TextAlign.center,
            ),
          if (availableProfits >= 5000)
            RequestProfitsContainerWidget(
              id: id,
              availableProfits: availableProfits,
            ),
          const SizedBox(
            height: 25,
          ),
          Text(
            S.of(context).your_profit_requests,
            style: TextStyles.style15.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          list.isEmpty
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: height / 5,
                    ),
                    Center(
                      child: Text(S.of(context).no_results),
                    ),
                  ],
                )
              : RequestsProfitsListViewWidget(
                  list: list,
                ),
        ],
      ),
    );
  }
}
