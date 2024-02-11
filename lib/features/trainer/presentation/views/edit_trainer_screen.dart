import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/edit_trainer_details_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/edit_custom_builder_widget.dart';

class EditTrainerScreen extends StatefulWidget {
  const EditTrainerScreen({super.key, required this.model});
  final TrainerModel model;

  @override
  State<EditTrainerScreen> createState() => _EditTrainerScreenState();
}

class _EditTrainerScreenState extends State<EditTrainerScreen> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fromHController = TextEditingController();
  TextEditingController toHController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descriptionController.dispose();
    priceController.dispose();
    fromHController.dispose();
    toHController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    descriptionController.text = widget.model.description;
    priceController.text = widget.model.price.toString();
    fromHController.text = widget.model.fromH;
    toHController.text = widget.model.toH;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).edit_trainer),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: EditTrainerDetailsContentWidget(
              formKey: formKey,
              descriptionController: descriptionController,
              priceController: priceController,
              fromHController: fromHController,
              toHController: toHController,
              autovalidateMode: autovalidateMode,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: EditCustomBuilderWidget(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      TrainersCubit.get(context).editTrainer(
                        trainer: widget.model,
                        description: descriptionController.text,
                        price: int.parse(priceController.text),
                        fromH: fromHController.text,
                        toH: toHController.text,
                      );
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
