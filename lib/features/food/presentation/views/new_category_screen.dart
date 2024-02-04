import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../data/models/supplement_model/supplement_model.dart';
import 'widgets/new_category_content_widget.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key, this.model});
  final SupplementModel? model;

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.title;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null
            ? S.of(context).edit_nutrition_classification
            : S.of(context).add_nutrition_classification,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NewCategoryContentWidget(
              nameController: nameController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model == null ? '' : widget.model!.image,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SupplementCustomButtonBuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit
                    : S.of(context).add,
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                      SupplementCubit.get(context).editCategory(
                        title: nameController.text,
                        imagePath: paths.isEmpty ? '' : paths.first,
                        oldModel: widget.model!,
                        context: context,
                      );
                    } else {
                      if (paths.isNotEmpty) {
                        SupplementCubit.get(context).addCategory(
                          title: nameController.text,
                          imagePath: paths.first,
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
