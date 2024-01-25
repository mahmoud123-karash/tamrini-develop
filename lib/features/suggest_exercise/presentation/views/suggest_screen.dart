import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/regex.dart';
import 'package:tamrini/features/suggest_exercise/presentation/manager/suggest_cubit/suggest_cubit.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/suggest_exercise_content_widget.dart';
import 'widgets/suggest_exercise_custom_button_builder_widget.dart';

class SuggestScreen extends StatefulWidget {
  const SuggestScreen({super.key});

  @override
  State<SuggestScreen> createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController youtubController = TextEditingController();

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
      appBar: myAppBar(S.of(context).suggest_exercise),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SuggestExerciseContentWidget(
              nameController: nameController,
              youtubController: youtubController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SuggestExerciseCustomButtonBuilderWidget(
                lable: S.of(context).suggest_exercise,
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (RegExp(RegexPatterns.allowedYoutubeUrlFormat)
                            .hasMatch(youtubController.text) ==
                        false) {
                      showSnackBar(context, S.of(context).youtub_uri_hint);
                    } else {
                      SuggestCubit.get(context).suggestExercise(
                        title: nameController.text,
                        url: youtubController.text,
                        imagePath: paths.isEmpty ? '' : paths.first,
                      );
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
