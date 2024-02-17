import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';

import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/food_custom_button_widget.dart';
import 'widgets/new_food_content_widget.dart';

class NewDietFoodScreen extends StatefulWidget {
  const NewDietFoodScreen({super.key, this.model});
  final DietFoodModel? model;

  @override
  State<NewDietFoodScreen> createState() => _NewDietFoodScreenState();
}

class _NewDietFoodScreenState extends State<NewDietFoodScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController foodDetailsController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.title;
      foodDetailsController.text = widget.model!.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    foodDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null ? S.of(context).edit_meal : S.of(context).add_meal,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NewFoodContentWidget(
              nameController: nameController,
              foodDetailsController: foodDetailsController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model == null
                  ? ''
                  : widget.model!.assets.isEmpty
                      ? ''
                      : widget.model!.assets.first,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FoodCustombuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit
                    : S.of(context).add,
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                      DietFoodCubit.get(context).editMeal(
                        name: nameController.text,
                        description: foodDetailsController.text,
                        paths: paths,
                        oldModel: widget.model!,
                        context: context,
                      );
                    } else {
                      if (paths.isNotEmpty) {
                        DietFoodCubit.get(context).addMeal(
                          name: nameController.text,
                          description: foodDetailsController.text,
                          paths: paths,
                          context: context,
                        );
                      } else {
                        showSnackBar(context, S.of(context).image_error);
                      }
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
