import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/writer_row_widget.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/nutrition/presentation/manager/select_cubit.dart/select_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/manager/select_cubit.dart/select_states.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/add_meal_custom_button_builder_widget.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/wieght_list_view_widget.dart';
import 'edit_remove_nutrition_row_buttons_widget.dart';
import 'favourite_icon_widget.dart';
import 'nutrition_buttons_row_widget.dart';
import 'nutrition_list_view_widget.dart';
import 'nutrition_values_colum_widget.dart';

class NutritionCalCulatorContentWidget extends StatefulWidget {
  const NutritionCalCulatorContentWidget({
    super.key,
    required this.model,
    required this.list,
    required this.isMyday,
    required this.id,
  });
  final ClassificationModel model;
  final List<NutritionModel> list;
  final bool isMyday;
  final String id;

  @override
  State<NutritionCalCulatorContentWidget> createState() =>
      _NutritionCalCulatorContentWidgetState();
}

class _NutritionCalCulatorContentWidgetState
    extends State<NutritionCalCulatorContentWidget> {
  TextEditingController searchController = TextEditingController();

  FixedExtentScrollController? _weightController;
  FixedExtentScrollController? _mealController;

  @override
  void initState() {
    SelectCubit.get(context).reset();
    super.initState();
    _weightController = FixedExtentScrollController(
        initialItem: SelectCubit.get(context).selectedWieght);
    _mealController = FixedExtentScrollController(
        initialItem: SelectCubit.get(context).selctedMeal);
  }

  @override
  void dispose() {
    searchController.dispose();
    _weightController!.dispose();
    _mealController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCubit, SelectStates>(
      builder: (context, state) {
        var cubit = SelectCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
              border: Border.all(
                color: appColor,
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (cubit.model.title != '')
                  FavoriteIconWidget(
                    model: MealModel(
                      carbs: cubit.model.carbs,
                      protein: cubit.model.proteins,
                      fat: cubit.model.fats,
                      calories: cubit.model.calories,
                      id: cubit.model.id ?? '',
                      name: cubit.model.title,
                    ),
                  ),
                NutritionButtonsRowWidget(
                  onPressedOne: () {
                    List<NutritionModel> finalList = searchController.text == ''
                        ? widget.list
                        : cubit.searchList;
                    if (finalList.isNotEmpty) {
                      cubit.selectmeal(finalList[0]);
                    }
                    showPickerDialog(
                      controller: _mealController!,
                      context: context,
                      selectedMeal: cubit.selctedMeal,
                      textField: searchField(
                        controller: searchController,
                        onChanged: (value) {
                          cubit.search(value, widget.list);
                        },
                      ),
                      child: BlocBuilder<SelectCubit, SelectStates>(
                        builder: (context, state) {
                          return NutritionlistViewWidget(
                            scrollController: _mealController!,
                            list: finalList,
                            onSelectedItemChanged: (selectedItem) {
                              cubit.selctedMeal = selectedItem;
                              cubit.selectmeal(finalList[selectedItem]);
                            },
                          );
                        },
                      ),
                    );
                  },
                  onPressedTwo: () {
                    showWeightDialog(
                      controller: _weightController!,
                      context: context,
                      selectedWeight: cubit.selectedWieght,
                      child: BlocBuilder<SelectCubit, SelectStates>(
                        builder: (context, state) => WeightListViewWidget(
                          onSelectedItemChanged: (selctedWieght) {
                            cubit.selectWieght(selctedWieght);
                          },
                          scrollController: _weightController!,
                        ),
                      ),
                    );
                  },
                ),
                const NutritionValuesColumWidget(),
                if (widget.isMyday)
                  AddMealCustomButtonBuilderWidget(
                    calories: cubit.model.calories * cubit.selectedWieght / 50,
                    protein: cubit.model.proteins * cubit.selectedWieght / 50,
                    fat: cubit.model.fats * cubit.selectedWieght / 50,
                    carbs: cubit.model.carbs * cubit.selectedWieght / 50,
                    id: widget.id,
                    grams: cubit.selectedWieght,
                    name: cubit.model.title,
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (cubit.model.user != null)
                  WriterWidget(user: cubit.model.user!),
                const SizedBox(
                  height: 10,
                ),
                if (!widget.isMyday)
                  EditRemoveNutritionRowButtonsWidget(model: cubit.model),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WriterWidget extends StatelessWidget {
  const WriterWidget({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          const Divider(),
          WriterRowWidget(
            model: user,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
