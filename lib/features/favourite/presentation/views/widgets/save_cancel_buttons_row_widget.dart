import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_states.dart';
import 'package:tamrini/generated/l10n.dart';

class SaveCancelButtonsRowWidget extends StatefulWidget {
  const SaveCancelButtonsRowWidget({
    super.key,
    required this.cancel,
    required this.weight,
    required this.model,
  });
  final VoidCallback cancel;
  final num weight;
  final MealModel model;

  @override
  State<SaveCancelButtonsRowWidget> createState() =>
      _SaveCancelButtonsRowWidgetState();
}

class _SaveCancelButtonsRowWidgetState
    extends State<SaveCancelButtonsRowWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
      listener: (context, state) {
        if (state is SucessGetFavoritesState) {
          isLoading = false;
          setState(() {});
          showSnackBar(context, S.of(context).success_add_a);
        }
      },
      builder: (context, state) {
        return isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: customButton(
                      onPressed: () {
                        isLoading = true;
                        setState(() {});
                        FavoriteCubit.get(context).editFavoriteMeal(
                          meal: widget.model,
                          wieght: widget.weight,
                        );
                      },
                      lable: S.of(context).save,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: customButton(
                      color: Colors.red,
                      onPressed: widget.cancel,
                      lable: S.of(context).cancel,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
