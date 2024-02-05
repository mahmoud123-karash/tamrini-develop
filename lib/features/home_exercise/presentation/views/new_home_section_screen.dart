import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/add_section_content_widget.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../data/models/home_exercise/home_exercise_model.dart';
import 'widgets/home_exercise_custon_button_builder_widget.dart';

class NewHomeSectionScreen extends StatefulWidget {
  const NewHomeSectionScreen({super.key, this.model});
  final HomeExerciseModel? model;

  @override
  State<NewHomeSectionScreen> createState() => _NewHomeSectionScreenState();
}

class _NewHomeSectionScreenState extends State<NewHomeSectionScreen> {
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
  void dispose() {
    nameController.dispose();
    orderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null
            ? S.of(context).edit_section
            : S.of(context).add_new_section,
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
              child: HomeExerciseCustomButtonBuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit
                    : S.of(context).add,
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                      HomeExerciseCubit.get(context).editSection(
                        id: widget.model!.id ?? '',
                        name: nameController.text,
                        order: int.parse(orderController.text),
                        paths: paths,
                        context: context,
                      );
                    } else {
                      if (paths.isNotEmpty) {
                        HomeExerciseCubit.get(context).addSection(
                          name: nameController.text,
                          order: int.parse(orderController.text),
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
