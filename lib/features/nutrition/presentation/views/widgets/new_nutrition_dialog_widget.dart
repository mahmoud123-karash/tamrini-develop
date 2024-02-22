import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/nutrition/presentation/manager/nutrition_cubit/nutrition_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/manager/nutrition_cubit/nutrition_states.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/new_nutrition_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/nutrition_model/nutrition_model.dart';
import 'cancel_dialog_text_button_widget.dart';

class NewNutritionDialogWidget extends StatefulWidget {
  const NewNutritionDialogWidget(
      {super.key, this.model, required this.categoryId});
  final NutritionModel? model;
  final String categoryId;

  @override
  State<NewNutritionDialogWidget> createState() =>
      _NewNutritionDialogWidgetState();
}

class _NewNutritionDialogWidgetState extends State<NewNutritionDialogWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController fatController = TextEditingController();
  TextEditingController carbController = TextEditingController();
  TextEditingController caloryController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    proteinController.dispose();
    fatController.dispose();
    carbController.dispose();
    caloryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.model != null) {
      nameController.text = widget.model!.title;
      proteinController.text = widget.model!.proteins.toString();
      fatController.text = widget.model!.fats.toString();
      carbController.text = widget.model!.carbs.toString();
      caloryController.text = widget.model!.calories.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).meal_name),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NewNutritionRowWidget(
                textField: addTextField(
                  lable: S.of(context).meal_name,
                  controller: nameController,
                  context: context,
                  autovalidateMode: autovalidateMode,
                ),
              ),
              NewNutritionRowWidget(
                textField: addTextField(
                  keyboardType: TextInputType.number,
                  lable: S.of(context).protien,
                  controller: proteinController,
                  context: context,
                  autovalidateMode: autovalidateMode,
                ),
              ),
              NewNutritionRowWidget(
                textField: addTextField(
                  keyboardType: TextInputType.number,
                  lable: S.of(context).fat,
                  controller: fatController,
                  context: context,
                  autovalidateMode: autovalidateMode,
                ),
              ),
              NewNutritionRowWidget(
                textField: addTextField(
                  keyboardType: TextInputType.number,
                  lable: S.of(context).carb,
                  controller: carbController,
                  context: context,
                  autovalidateMode: autovalidateMode,
                ),
              ),
              NewNutritionRowWidget(
                textField: addTextField(
                  keyboardType: TextInputType.number,
                  lable: S.of(context).calories,
                  controller: caloryController,
                  context: context,
                  autovalidateMode: autovalidateMode,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        BlocBuilder<NutritionCubit, NutritionStates>(
          builder: (context, state) {
            if (state is LoadingGetNutritionState) {
              return Container();
            } else {
              return const CancelDiologTextButtonWidget();
            }
          },
        ),
        BlocConsumer<NutritionCubit, NutritionStates>(
          listener: (context, state) {
            if (state is ErrorGetNutritionState) {
              showSnackBar(context, state.message);
              NutritionCubit.get(context).getData(id: widget.categoryId);
            }
          },
          builder: (context, state) {
            if (state is LoadingGetNutritionState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                      NutritionCubit.get(context).editNutrition(
                        oldModel: widget.model!,
                        categoryId: widget.categoryId,
                        name: nameController.text,
                        protien: double.parse(proteinController.text),
                        fat: double.parse(fatController.text),
                        carb: double.parse(carbController.text),
                        calories: double.parse(caloryController.text),
                        context: context,
                      );
                    } else {
                      NutritionCubit.get(context).addNutrition(
                        categoryId: widget.categoryId,
                        name: nameController.text,
                        protien: double.parse(proteinController.text),
                        fat: double.parse(fatController.text),
                        carb: double.parse(carbController.text),
                        calories: double.parse(caloryController.text),
                        context: context,
                      );
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                child: Text(
                  widget.model != null ? S.of(context).edit : S.of(context).add,
                  style: TextStyles.style13.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
