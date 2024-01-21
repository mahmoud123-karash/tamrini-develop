import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/presentation/manager/classification_cubit/classification_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/classification_cubit/classification_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/nutrition_classification_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'classification_loading_widget.dart';
import 'message_builder_widget.dart';

class NutritionClassificationListViewBuilderWidget extends StatelessWidget {
  const NutritionClassificationListViewBuilderWidget({
    super.key,
    required this.isMyday,
    required this.id,
  });
  final bool isMyday;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassificationCubit, ClassificationStates>(
      builder: (context, state) {
        if (state is SucessGetClassificationState) {
          if (state.list.isEmpty) {
            return MessageBuilderWidget(message: S.of(context).no_results);
          }
          return NutritionClassificationListViewWidget(
            list: state.list,
            isMyday: isMyday,
            id: id,
          );
        } else if (state is ErrorGetClassificationState) {
          return MessageBuilderWidget(message: state.message);
        } else {
          return const CLassificationLoadingWidget();
        }
      },
    );
  }
}
