import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/build_store_custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/new_store_content_widget.dart';

class NewStoreScreen extends StatefulWidget {
  const NewStoreScreen({super.key, this.model});
  final StoreModel? model;

  @override
  State<NewStoreScreen> createState() => _NewStoreScreenState();
}

class _NewStoreScreenState extends State<NewStoreScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.name;
      contactController.text = widget.model!.contact;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null
            ? S.of(context).edit_store
            : S.of(context).build_store,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NewStoreContentWidget(
              nameController: nameController,
              contactController: contactController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model != null ? widget.model!.image : "",
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: StoreCustomButtonBuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit
                    : S.of(context).build_store,
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
