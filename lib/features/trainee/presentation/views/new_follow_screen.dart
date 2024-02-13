import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/follow_question_list_view_widget.dart';
import 'widgets/follow_up_images_widget.dart';

class NewFollowScreen extends StatefulWidget {
  const NewFollowScreen({super.key, required this.questions});
  final List<String> questions;

  @override
  State<NewFollowScreen> createState() => _NewFollowScreenState();
}

class _NewFollowScreenState extends State<NewFollowScreen> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  List<TextEditingController> controllers = [];
  var formKey = GlobalKey<FormState>();

  int page = 0;

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    super.initState();
    for (int i = 0; i < widget.questions.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).add_new_follow),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: page == 0
                    ? FollowQuestionListViewWidget(
                        questions: widget.questions,
                        controllers: controllers,
                        autovalidateMode: autovalidateMode,
                      )
                    : const FollowUpImagesWidget(),
              ),
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
                child: customButton(
                  onPressed: () {
                    List<String> paths = ImageCubit.get(context).paths;
                    if (page == 0) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        page++;
                        setState(() {});
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    } else {
                      if (paths.isEmpty) {
                        showSnackBar(context, S.of(context).image_hint);
                      } else {}
                    }
                  },
                  lable: page == 0 ? S.of(context).next : S.of(context).add,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
