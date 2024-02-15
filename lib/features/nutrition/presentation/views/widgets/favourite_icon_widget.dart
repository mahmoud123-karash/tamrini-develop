import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_states.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({super.key, required this.model});
  final MealModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        if (state is SucessGetFavoritesState) {
          List<MealModel> list = state.list;
          bool isFavorite = list.any((element) => element.id == model.id);
          return Align(
            alignment: Intl.getCurrentLocale() == 'ar'
                ? Alignment.topLeft
                : Alignment.topRight,
            child: IconButton(
              onPressed: () {
                if (isFavorite) {
                  FavoriteCubit.get(context).removeFavoriteMeal(meal: model);
                } else {
                  FavoriteCubit.get(context).addFavoriteMeal(meal: model);
                }
              },
              icon: isFavorite
                  ? const Icon(
                      Ionicons.heart,
                      color: Colors.red,
                    )
                  : Icon(
                      Ionicons.heart_outline,
                      color: appColor,
                    ),
              iconSize: 30,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
