import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_states.dart';
import 'package:tamrini/generated/l10n.dart';
import '../../manager/calculator_cubit.dart/calculator_cubit.dart';
import 'calutator_container_widget.dart';
import 'calculator_gender_colum_widget.dart';

class CalCulatorGenderWidget extends StatelessWidget {
  const CalCulatorGenderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorStates>(
      builder: (context, state) {
        var cubit = CalculatorCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CalculatorContainerWidget(
                onPress: () {
                  cubit.selectedGender = Gender.m;
                  cubit.calculate();
                },
                colory: cubit.selectedGender == Gender.m
                    ? appColor
                    : Theme.of(context).cardColor,
                cardChild: GenderColumnWidget(
                  icony: Icons.male,
                  texty: S.of(context).male,
                  colory: cubit.selectedGender == Gender.m
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            Expanded(
              child: CalculatorContainerWidget(
                onPress: () {
                  cubit.selectedGender = Gender.f;
                  cubit.calculate();
                },
                colory: cubit.selectedGender == Gender.f
                    ? appColor
                    : Theme.of(context).cardColor,
                cardChild: GenderColumnWidget(
                  icony: Icons.female,
                  texty: S.of(context).female,
                  colory: cubit.selectedGender == Gender.f
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
