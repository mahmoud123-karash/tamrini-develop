import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/date_sub_end_colum_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SubEndDateRowWidget extends StatelessWidget {
  const SubEndDateRowWidget(
      {super.key, required this.subDate, required this.endDate});
  final DateTime subDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DateSubEndColumWidget(
          label: S.of(context).sub_date,
          color: Colors.white,
          value: DateFormat('yyyy-MM-dd', 'en').format(subDate).toString(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Container(
            width: 2,
            height: 50,
            color: blackColor,
          ),
        ),
        DateSubEndColumWidget(
          label: S.of(context).end_date,
          color: Colors.red,
          value: DateFormat('yyyy-MM-dd', 'en').format(endDate).toString(),
        ),
      ],
    );
  }
}
