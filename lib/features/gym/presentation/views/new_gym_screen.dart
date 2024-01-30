import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/gym_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/new_gym_content_widget.dart';

class NewGymScreen extends StatefulWidget {
  const NewGymScreen({super.key, this.model});
  final GymModel? model;

  @override
  State<NewGymScreen> createState() => _NewGymScreenState();
}

class _NewGymScreenState extends State<NewGymScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    CacheHelper.removeData(key: 'latmap');
    CacheHelper.removeData(key: 'langmap');
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.name;
      priceController.text = widget.model!.price.toString();
      descriptionController.text = widget.model!.description.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null ? S.of(context).edit_gym : S.of(context).add_gym,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NewGymContentWidget(
              nameController: nameController,
              descriptionController: descriptionController,
              priceController: priceController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              images: widget.model == null ? [] : widget.model!.assets,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GymCustombuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit
                    : S.of(context).add,
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                    } else {
                      if (paths.isNotEmpty) {
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
