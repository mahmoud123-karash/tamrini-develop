import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_states.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_cubit.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_content_widget.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/message_diet_food_list_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class DietFoodContentBuilderWidget extends StatelessWidget {
  const DietFoodContentBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DietFoodCubit, DietFoodStates>(
      builder: (context, state) {
        if (state is SucessGetDietFoodState) {
          if (state.list.isEmpty) {
            return MessageDietFoodWidget(message: S.of(context).no_results);
          }
          return DietFoodContentWidget(models: state.list);
        } else if (state is ErrorGetDietFoodState) {
          return MessageDietFoodWidget(message: state.message);
        } else {
          return loadingWidget();
        }
      },
    );
  }
}
