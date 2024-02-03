import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/manager/answer_cubit/answer_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/answer_cubit/answer_states.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/edit_answer_bottom_sheet_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'option_tab_widget.dart';

class AnswerOptionsBottomSheetWidget extends StatefulWidget {
  const AnswerOptionsBottomSheetWidget({
    super.key,
    required this.model,
    required this.question,
  });
  final AnswerModel model;
  final QuestionModel question;

  @override
  State<AnswerOptionsBottomSheetWidget> createState() =>
      _AnswerOptionsBottomSheetWidgetState();
}

class _AnswerOptionsBottomSheetWidgetState
    extends State<AnswerOptionsBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AnswerCubit, AnswerStates>(
      listener: (context, state) {
        if (state is SucessUpdateAnswerState) {
          if (mounted) {
            Navigator.pop(context);
            showSnackBar(context, S.of(context).success_update_answer);
          }
        }
        if (state is SucessRemoveAnswerState) {
          if (mounted) {
            Navigator.pop(context);
            showSnackBar(context, S.of(context).success_remove_answer);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionTabWidget(
                color: appColor,
                icon: Icons.edit,
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return EditAnswerBottomSheetWidget(
                        model: widget.model,
                        question: widget.question,
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              OptionTabWidget(
                color: greyColor,
                icon: Icons.share,
                onPressed: () {
                  share(title: S.of(context).share, text: widget.model.answer);
                },
              ),
              const Spacer(),
              OptionTabWidget(
                color: Colors.red,
                icon: Icons.delete,
                onPressed: () {
                  AnswerCubit.get(context).removeAnswer(
                    aModel: widget.model,
                    model: widget.question,
                    context: context,
                    id: widget.question.id!,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
