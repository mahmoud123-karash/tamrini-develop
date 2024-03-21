import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/theme_cubit/theme_cubit.dart';
import '../manager/theme_cubit/theme_states.dart';
import 'widgets/add_follow_custom_button_widget.dart';
import 'widgets/follow_question_list_view_widget.dart';
import 'widgets/follow_up_images_widget.dart';

class NewFollowScreen extends StatefulWidget {
  const NewFollowScreen({
    super.key,
    required this.questions,
    required this.model,
    required this.logo,
  });
  final List<String> questions;
  final TraineeModel model;
  final String logo;

  @override
  State<NewFollowScreen> createState() => _NewFollowScreenState();
}

class _NewFollowScreenState extends State<NewFollowScreen> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  List<TextEditingController> controllers = [];
  var formKey = GlobalKey<FormState>();

  late int page;

  @override
  void initState() {
    page = widget.questions.isEmpty ? 1 : 0;
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
    return BlocBuilder<ThemeCubit, ThemeStates>(
      builder: (context, state) {
        Color themeColor = ThemeCubit.get(context).themeColor;
        return Scaffold(
          appBar: themeAppBar(
            S.of(context).add_new_follow,
            backgroundColor: themeColor,
          ),
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
                    child: Column(
                      children: [
                        CirclarImageWidget(image: widget.logo, radius: 50),
                        const SizedBox(
                          height: 15,
                        ),
                        page == 0
                            ? FollowQuestionListViewWidget(
                                themeColor: themeColor,
                                questions: widget.questions,
                                controllers: controllers,
                                autovalidateMode: autovalidateMode,
                              )
                            : FollowUpImagesWidget(
                                themeColor: themeColor,
                              ),
                      ],
                    ),
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
                    child: AddFollowCustomWidget(
                      themeColor: themeColor,
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
                          } else {
                            List<FollowUpData> followList = getAnswers();
                            UserCourseCubit.get(context).addNewFollow(
                              traineeModel: widget.model,
                              paths: paths,
                              followUpData: followList,
                            );
                          }
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
      },
    );
  }

  List<FollowUpData> getAnswers() {
    List<FollowUpData> followList = [];
    for (int i = 0; i < controllers.length; i++) {
      String answer = controllers[i].text;
      String question = widget.questions[i];
      followList.add(
        FollowUpData(answer: answer, question: question),
      );
    }
    return followList;
  }
}
