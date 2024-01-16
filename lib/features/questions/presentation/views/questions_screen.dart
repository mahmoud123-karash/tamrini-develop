import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/add_question_bottom_sheet_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/user_cubit/user_cubit.dart';
import 'widgets/questions_stream_builder_widget.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
        getIt.get<QuestionRepoImpl>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).questtion),
          centerTitle: true,
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
        body: const QuestionsStreamBuilderWidget(),
      ),
    );
  }
}
