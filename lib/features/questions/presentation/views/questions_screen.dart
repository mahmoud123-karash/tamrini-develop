import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
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
    return Scaffold(
      appBar: myAppBar(
        S.of(context).questtion,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const AddQuestionBottomSheetWidget(),
          );
        },
        child: const Icon(Ionicons.add_sharp),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500))
              .then((value) {
            if (mounted) {
              QuestionCubit.get(context).getQuestions(
                message: S.of(context).update_success,
              );
            }
          });
        },
        child: const QuestionsContentBuilderWidget(),
      ),
    );
  }
}
