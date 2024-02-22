import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:tamrini/features/favourite/presentation/views/widgets/meal_name_icon_row_widget.dart';
import 'package:tamrini/features/favourite/presentation/views/widgets/value_row_widget.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/wieght_list_view_widget.dart';

import 'meal_wieght_row_widget.dart';
import 'save_cancel_buttons_row_widget.dart';

class MealItemWidget extends StatefulWidget {
  const MealItemWidget({super.key, required this.model});
  final MealModel model;

  @override
  State<MealItemWidget> createState() => _MealItemWidgetState();
}

class _MealItemWidgetState extends State<MealItemWidget> {
  FixedExtentScrollController? _weightController;
  late num weight;

  @override
  void initState() {
    weight = widget.model.wieght;
    super.initState();
    _weightController = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _weightController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showWeightDialog(
          controller: _weightController!,
          context: context,
          selectedWeight: weight.toInt(),
          child: WeightListViewWidget(
            onSelectedItemChanged: (selctedWieght) {
              weight = selctedWieght;
              setState(() {});
            },
            scrollController: _weightController!,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: appColor,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              MealWieghtRowWidget(weight: weight),
              const SizedBox(
                height: 5,
              ),
              MealNameIconRowWidget(
                name: widget.model.name,
                remove: () {
                  weight = widget.model.wieght;
                  setState(() {});
                  FavoriteCubit.get(context).removeFavoriteMeal(
                    meal: widget.model,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ValuesRowWidget(
                calories:
                    (widget.model.calories * weight / 50).toStringAsFixed(0),
                protien:
                    (widget.model.protein * weight / 50).toStringAsFixed(0),
                fat: (widget.model.fat * weight / 50).toStringAsFixed(0),
                carb: (widget.model.carbs * weight / 50).toStringAsFixed(0),
              ),
              const SizedBox(
                height: 10,
              ),
              if (widget.model.wieght != weight)
                SaveCancelButtonsRowWidget(
                  model: widget.model,
                  weight: weight,
                  cancel: () {
                    weight = widget.model.wieght;
                    setState(() {});
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
