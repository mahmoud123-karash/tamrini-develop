import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/food/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/food/presentation/manager/select_cubit.dart/select_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/select_cubit.dart/select_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/nutrition_buttons_row_widget.dart';
import 'add_meal_to_myday_custom_button_widget.dart';
import 'nutrition_list_view_widget.dart';
import 'nutrition_values_colum_widget.dart';
import 'wieght_list_view_widget.dart';

class NutritionCalCulatorContentWidget extends StatefulWidget {
  const NutritionCalCulatorContentWidget(
      {super.key,
      required this.model,
      required this.list,
      required this.isMyday});
  final ClassificationModel model;
  final List<NutritionModel> list;
  final bool isMyday;

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
    var size = MediaQuery.of(context).size;
    return BlocBuilder<SelectCubit, SelectStates>(
      builder: (context, state) {
        var cubit = SelectCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            height: size.height / 2,
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
              children: [
                NutritionButtonsRowWidget(
                  onPressedOne: () {
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
                          List<NutritionModel> finalList =
                              searchController.text == ''
                                  ? widget.list
                                  : cubit.searchList;
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
                if (widget.isMyday) const AddMealToMaydaycustomButtonWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
