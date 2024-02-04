import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/new_supplement_content_widget.dart';

class NewSupplementScreen extends StatefulWidget {
  const NewSupplementScreen({super.key, this.model, required this.categoryId});
  final SupplementData? model;
  final String categoryId;

  @override
  State<NewSupplementScreen> createState() => _NewSupplementScreenState();
}

class _NewSupplementScreenState extends State<NewSupplementScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.title;
      descriptionController.text = widget.model!.description;
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
            ? S.of(context).edit_supplememt
            : S.of(context).add_supplement,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NewSupplementContentWidget(
              nameController: nameController,
              descriptionController: descriptionController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model == null
                  ? ''
                  : widget.model!.images.isEmpty
                      ? ''
                      : widget.model!.images.first,
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
                      SupplementCubit.get(context).editSupplement(
                        oldModel: widget.model!,
                        id: widget.categoryId,
                        imagePath: paths.isEmpty ? "" : paths.first,
                        title: nameController.text,
                        description: descriptionController.text,
                        context: context,
                      );
                    } else {
                      if (paths.isNotEmpty) {
                        SupplementCubit.get(context).addSupplement(
                          id: widget.categoryId,
                          imagePath: paths.first,
                          title: nameController.text,
                          description: descriptionController.text,
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
