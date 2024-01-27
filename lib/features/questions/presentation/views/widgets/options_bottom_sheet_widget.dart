import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_cubit.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/edit_question_bottom_sheet_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class OptionsBottomSheetWidget extends StatelessWidget {
  const OptionsBottomSheetWidget({
    super.key,
    required this.isAdmin,
    required this.model,
    required this.isDetails,
    required this.token,
  });
  final QuestionModel model;
  final bool isAdmin;
  final bool isDetails;
  final String token;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListTile(
                tileColor: appColor.withOpacity(0.1),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) =>
                        EditQuestionBottomSheetWidget(model: model),
                  );
                },
                title: Text(S.of(context).edit),
                leading: const Icon(
                  Icons.edit,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                tileColor: appColor.withOpacity(0.1),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                onTap: () {
                  share(title: S.of(context).share, text: model.body);
                },
                title: Text(S.of(context).share),
                leading: const Icon(
                  Icons.share,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                tileColor: Colors.red.withOpacity(0.1),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                onTap: () {
                  QuestionCubit.get(context)
                      .removeQuestion(context: context, id: model.id!);
                },
                title: Text(S.of(context).remove_question),
                leading: const Icon(
                  Icons.delete_rounded,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              if (isAdmin)
                ListTile(
                  tileColor: Colors.red.withOpacity(0.1),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  onTap: () {
                    QuestionCubit.get(context).banQuestion(
                      model: QuestionModel(
                        date: model.date,
                        body: model.body,
                        askerUid: model.askerUid,
                        answersCount: model.answersCount,
                        answers: model.answers,
                        isBanned: true,
                      ),
                      context: context,
                      id: model.id!,
                      token: token,
                    );
                  },
                  title: Text(S.of(context).ban_question),
                  leading: const Icon(
                    Icons.remove_circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
