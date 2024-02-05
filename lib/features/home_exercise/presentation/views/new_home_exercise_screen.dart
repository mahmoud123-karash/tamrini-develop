import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/core/utils/regex.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/home_exercise_custon_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/new_home_exercise_content_widget.dart';

class NewHomeExerciseScreen extends StatefulWidget {
  const NewHomeExerciseScreen({super.key, this.model});
  final Data? model;

  @override
  State<NewHomeExerciseScreen> createState() => _NewHomeExerciseScreenState();
}

class _NewHomeExerciseScreenState extends State<NewHomeExerciseScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController youtubController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.title;
      descriptionController.text = widget.model!.description;
      youtubController.text = checkVedioformat(widget.model!.assets);
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    youtubController.dispose();
    super.dispose();
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
            child: NewHomeExerciseContentWidget(
              nameController: nameController,
              descriptionController: descriptionController,
              youtubController: youtubController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model != null
                  ? checkImageformat(widget.model!.assets)
                  : "",
              isUri: widget.model != null
                  ? checkVedioformat(widget.model!.assets) != ''
                  : false,
              vedioUri: widget.model != null ? widget.model!.assets[1] : '',
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
                      if (RegExp(RegexPatterns.allowedYoutubeUrlFormat)
                              .hasMatch(youtubController.text) ==
                          false) {
                        showSnackBar(context, S.of(context).youtub_uri_hint);
                      } else {
                        if (checkImageformat(widget.model!.assets) == '' &&
                            paths.isEmpty) {
                          showSnackBar(context, S.of(context).image_error);
                        } else {}
                      }
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
