import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/add_section_content_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/add_section_custom_button_builder_widget.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class NewSectionScreen extends StatefulWidget {
  const NewSectionScreen({super.key, this.model});
  final ExerciseModel? model;

  @override
  State<NewSectionScreen> createState() => _NewSectionScreenState();
}

class _NewSectionScreenState extends State<NewSectionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.title ?? '';
      orderController.text = widget.model!.order.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).add_new_section,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: AddSectionContentWidget(
              nameController: nameController,
              orderController: orderController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model != null ? widget.model!.image ?? '' : '',
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AddSectionCustomButtonBuilderWidget(
                isEdit: widget.model != null,
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                      log(widget.model!.id!);
                      ExerciseCubit.get(context).editSection(
                        id: widget.model!.id!,
                        oldModel: widget.model!,
                        title: nameController.text,
                        order: int.parse(orderController.text),
                        imagePth: paths.isEmpty ? '' : paths.first,
                        data: widget.model!.data ?? [],
                      );
                    } else {
                      if (paths.isNotEmpty) {
                        ExerciseCubit.get(context).addNewSection(
                          title: nameController.text,
                          order: int.parse(orderController.text),
                          imagePth: paths.first,
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
