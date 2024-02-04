import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/nutrition/presentation/manager/select_cubit.dart/select_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/manager/select_cubit.dart/select_states.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/nurition_value_lable_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class NutritionValuesColumWidget extends StatelessWidget {
  const NutritionValuesColumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<SelectCubit, SelectStates>(
      builder: (context, state) {
        NutritionModel model = SelectCubit.get(context).model;
        int selectedWieght = SelectCubit.get(context).selectedWieght;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 5,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (model.title != '')
                NutritionValueLableWidget(
                  lable: model.title,
                  value: selectedWieght.toDouble(),
                ),
              SizedBox(
                height: height / 30,
              ),
              NutritionValueLableWidget(
                lable: S.of(context).protien,
                value: model.proteins * selectedWieght / 50,
              ),
              SizedBox(
                height: height / 22,
              ),
              NutritionValueLableWidget(
                lable: S.of(context).fat,
                value: model.fats * selectedWieght / 50,
              ),
              SizedBox(
                height: height / 22,
              ),
              NutritionValueLableWidget(
                lable: S.of(context).carb,
                value: model.carbs * selectedWieght / 50,
              ),
              SizedBox(
                height: height / 22,
              ),
              NutritionValueLableWidget(
                lable: S.of(context).calories,
                value: model.calories * selectedWieght / 50,
                iscalory: true,
              )
            ],
          ),
        );
      },
    );
  }
}
