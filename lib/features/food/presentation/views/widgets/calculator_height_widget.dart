import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_states.dart';
import 'package:tamrini/generated/l10n.dart';

class CalculatorHieghtWidget extends StatelessWidget {
  const CalculatorHieghtWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorStates>(
      builder: (context, state) {
        var cubit = CalculatorCubit.get(context);
        return Container(
          height: 150.sp,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: appColor,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).height,
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    cubit.height.toString(),
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    S.of(context).cm,
                    style: TextStyle(
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: appColor,
                  inactiveTrackColor: Colors.grey,
                  thumbColor: appColor,
                  overlayColor: appColor.withOpacity(0.2),
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 10),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 20),
                ),
                child: Slider(
                  value: cubit.height.toDouble(),
                  min: 120,
                  max: 220,
                  onChanged: (double value) {
                    cubit.height = value.round();
                    cubit.calculate();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
