import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_cubit.dart';

import 'package:tamrini/features/questions/presentation/views/widgets/add_question_bottom_sheet_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/questions_content_builder_widget.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return Scaffold(
      appBar: myAppBar(
        S.of(context).questtion,
      ),
      floatingActionButton: BlocProvider(
        create: (context) => UserCubit()..getUser(uid: uid),
        child: BlocBuilder<UserCubit, UserStates>(
          builder: (context, state) {
            if (state is SucessGetUserState) {
              if (state.model.isBanned) {
                return Container();
              }
              return FloatingActionButton(
                backgroundColor: appColor,
                onPressed: () async {
                  if (uid != '') {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) =>
                          const AddQuestionBottomSheetWidget(),
                    );
                  } else {
                    showWaringLoginDialog(context);
                  }
                },
                child: const Icon(Ionicons.add_sharp),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500))
              .then((value) {
            if (mounted) {
              QuestionCubit.get(context).getQuestions();
            }
          });
        },
        child: const QuestionsContentBuilderWidget(),
      ),
    );
  }
}
