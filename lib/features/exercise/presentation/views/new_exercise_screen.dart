import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/core/utils/regex.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/custom_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/add_exercise_content_widget.dart';

class NewExerciseScreen extends StatefulWidget {
  const NewExerciseScreen({super.key, this.model});
  final DataModel? model;

  @override
  State<NewExerciseScreen> createState() => _NewExerciseScreenState();
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController youtubController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.title ?? '';
      descriptionController.text = widget.model!.description ?? '';
      youtubController.text = checkVedioformat(widget.model!.assets ?? []);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null
            ? S.of(context).edit_exercise
            : S.of(context).add_exercise,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: AddExerciseContentWidget(
              nameController: nameController,
              descriptionController: descriptionController,
              youtubController: youtubController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model == null
                  ? ''
                  : checkImageformat(widget.model!.assets ?? []) != ''
                      ? widget.model!.assets!.first
                      : '',
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonBuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit_exercise
                    : S.of(context).add_exercise,
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                      if (RegExp(RegexPatterns.allowedYoutubeUrlFormat)
                              .hasMatch(youtubController.text) ==
                          false) {
                        showSnackBar(context, S.of(context).youtub_uri_hint);
                      } else {}
                    } else {
                      if (paths.isNotEmpty) {
                        if (RegExp(RegexPatterns.allowedYoutubeUrlFormat)
                                .hasMatch(youtubController.text) ==
                            false) {
                          showSnackBar(context, S.of(context).youtub_uri_hint);
                        } else {}
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
