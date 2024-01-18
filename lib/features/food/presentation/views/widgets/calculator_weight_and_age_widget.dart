import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/calculator_wieght_container_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class CalculatorWieghtAndAgeWidget extends StatelessWidget {
  const CalculatorWieghtAndAgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorStates>(
      builder: (context, state) {
        var cubit = CalculatorCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WieghtContainerWidget(
              isAge: false,
              lable: S.of(context).weight,
              number: cubit.wight,
            ),
            WieghtContainerWidget(
              isAge: true,
              lable: S.of(context).age,
              number: cubit.age,
            ),
          ],
        );
      },
    );
  }
}
