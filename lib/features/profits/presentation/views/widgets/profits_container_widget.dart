import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'profits_colum_profits_widget.dart';

class ProfitsContainerWidget extends StatelessWidget {
  const ProfitsContainerWidget({super.key, required this.profits});
  final num profits;

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
        child: Row(
          children: [
            ProfitsColumProfitsWidget(profits: profits),
            const Spacer(),
            const Icon(
              Icons.attach_money,
              size: 50,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
