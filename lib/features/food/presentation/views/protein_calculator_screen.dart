import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/calculator_height_widget.dart';
import 'package:tamrini/features/food/presentation/views/widgets/calculator_number_of_calories_widget.dart';
import 'package:tamrini/features/food/presentation/views/widgets/calculator_values_colum_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/calculator_gender_widget.dart';
import 'widgets/calculator_target_widget.dart';
import 'widgets/calculator_weight_and_age_widget.dart';

class ProteinCalculatorScreen extends StatefulWidget {
  const ProteinCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<ProteinCalculatorScreen> createState() =>
      _ProteinCalculatorScreenState();
}

class _ProteinCalculatorScreenState extends State<ProteinCalculatorScreen> {
  FixedExtentScrollController? activityController;
  FixedExtentScrollController? purposeController;

  @override
  void initState() {
    super.initState();
    activityController = FixedExtentScrollController();
    purposeController = FixedExtentScrollController();
  }

  @override
  void dispose() {
    activityController!.dispose();
    purposeController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubit(),
      child: Scaffold(
        appBar: myAppBar(S.of(context).protein_calculator),
        body: BlocBuilder<CalculatorCubit, CalculatorStates>(
          builder: (context, state) {
            var cubit = CalculatorCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CalCulatorGenderWidget(),
                      const CalculatorHieghtWidget(),
                      const CalculatorWieghtAndAgeWidget(),
                      CalculatorTargetWidget(
                        selctedItem: cubit.selectedPurpose,
                        controller: purposeController!,
                        selectedItem:
                            cubit.names(context)[cubit.selectedPurpose],
                        onSelectedItemChanged: (selectedItem) {
                          cubit.selectedPurpose = selectedItem;
                          cubit.target = Target.values[selectedItem];
                          cubit.calculate();
                        },
                        list: cubit.names(context),
                      ),
                      CalculatorTargetWidget(
                        selctedItem: cubit.selectedActivity,
                        controller: activityController!,
                        selectedItem:
                            cubit.activities(context)[cubit.selectedActivity],
                        onSelectedItemChanged: (selectedItem) {
                          cubit.selectedActivity = selectedItem;
                          cubit.activityLevel =
                              ActivityLevel.values[selectedItem];
                          cubit.calculate();
                        },
                        list: cubit.activities(context),
                      ),
                      const CalculatorNumberCaloriesWidget(),
                      const Divider(
                        endIndent: 20,
                        indent: 20,
                      ),
                      CalculatorValuesColumWidget(cubit: cubit)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
