import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'profits_colum_profits_widget.dart';

class ProfitsContainerWidget extends StatelessWidget {
  const ProfitsContainerWidget({
    super.key,
    required this.availableProfits,
    required this.totalProfits,
  });
  final num availableProfits;
  final num totalProfits;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ProfitsColumProfitsWidget(
          availableProfits: availableProfits,
          totalProfits: totalProfits,
        ),
      ),
    );
  }
}
