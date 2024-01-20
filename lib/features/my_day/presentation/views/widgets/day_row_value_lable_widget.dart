import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class DayRowValueLableWidget extends StatelessWidget {
  const DayRowValueLableWidget({
    super.key,
    required this.value,
    required this.lable,
    this.isCalory = false,
  });
  final String value, lable;
  final bool isCalory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Row(
        children: [
          Text(lable),
          const Spacer(),
          Text(
            '$value ${isCalory ? S.of(context).calory : S.of(context).g}',
          ),
        ],
      ),
    );
  }
}
