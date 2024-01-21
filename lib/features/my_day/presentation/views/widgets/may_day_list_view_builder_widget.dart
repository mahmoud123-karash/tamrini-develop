import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/my_day/presentation/manager/article_cubit/day_cubit.dart';
import 'package:tamrini/features/my_day/presentation/manager/article_cubit/day_states.dart';
import 'package:tamrini/features/my_day/presentation/views/widgets/my_day_list_view_widget.dart';
import 'package:tamrini/features/my_day/presentation/views/widgets/my_day_message_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class MyDayListViewBuilderWidget extends StatelessWidget {
  const MyDayListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayCubit, DayStates>(
      builder: (context, state) {
        if (state is SucessGetDayState) {
          if (state.list.isEmpty) {
            return MyDayMessageBuilderWidget(message: S.of(context).no_results);
          }
          return MyDayListViewWidget(
            list: state.list,
          );
        } else if (state is ErrorGetDayState) {
          return MyDayMessageBuilderWidget(message: state.message);
        } else {
          return loadingWidget();
        }
      },
    );
  }
}
