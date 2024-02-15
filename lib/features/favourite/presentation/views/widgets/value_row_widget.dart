import 'package:flutter/material.dart';
import 'package:tamrini/features/favourite/presentation/views/widgets/container_values_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ValuesRowWidget extends StatelessWidget {
  const ValuesRowWidget(
      {super.key,
      required this.calories,
      required this.protien,
      required this.fat,
      required this.carb});
  final String calories, protien, fat, carb;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ContainerValuesWidget(
          value: calories,
          lable: S.of(context).calories,
        ),
        ContainerValuesWidget(
          value: protien,
          lable: S.of(context).protien,
        ),
        ContainerValuesWidget(
          value: fat,
          lable: S.of(context).fat,
        ),
        ContainerValuesWidget(
          value: carb,
          lable: S.of(context).carb,
        ),
      ],
    );
  }
}
