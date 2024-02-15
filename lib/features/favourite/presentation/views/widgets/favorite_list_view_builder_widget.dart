import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_states.dart';
import 'package:tamrini/features/favourite/presentation/views/widgets/favorite_meal_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'message_builder_widget.dart';

class FavoriteListViewBuilderWidget extends StatelessWidget {
  const FavoriteListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        if (state is SucessGetFavoritesState) {
          if (state.list.isEmpty) {
            return MessageBuilderWidget(message: S.of(context).no_results);
          }
          return FavoriteMealListViewWidget(
            list: state.list,
          );
        } else if (state is ErrorGetFavoritesState) {
          return MessageBuilderWidget(
            message: state.message,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
