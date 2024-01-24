import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/add_section_content_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/add_section_custom_button_builder_widget.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class AddNewSectionScreen extends StatefulWidget {
  const AddNewSectionScreen({super.key});

  @override
  State<AddNewSectionScreen> createState() => _AddNewSectionScreenState();
}

class _AddNewSectionScreenState extends State<AddNewSectionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
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
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AddSectionCustomButtonBuilderWidget(
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ExerciseCubit.get(context).addNewSection(
                      title: nameController.text,
                      order: int.parse(orderController.text),
                      imagePth: paths.first,
                    );
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
