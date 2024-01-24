import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/add_section_content_widget.dart';
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
              child: customButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                lable: S.of(context).add_section,
              ),
            ),
          )
        ],
      ),
    );
  }
}
