// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_states.dart';
import 'package:tamrini/generated/l10n.dart';

class WriteAnswerWidget extends StatefulWidget {
  const WriteAnswerWidget({super.key, required this.model});
  final QuestionModel model;

  @override
  State<WriteAnswerWidget> createState() => _WriteAnswerWidgetState();
}

class _WriteAnswerWidgetState extends State<WriteAnswerWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            if (controller.text != '')
              BlocListener<QuestionCubit, QuestionStates>(
                listener: (context, state) {
                  if (state is SucessUpdateQuestionState) {
                    controller.clear();
                  }
                  if (state is ErrorUpdateQuestionState) {
                    showSnackBar(context, state.message);
                  }
                },
                child: GestureDetector(
                  onTap: () async {
                    if (await InternetConnectionChecker().hasConnection) {
                      List<AnswerModel> list = widget.model.answers;
                      list.add(
                        AnswerModel(
                          date: Timestamp.now(),
                          answer: controller.text,
                          userUid: CacheHelper.getData(key: 'uid'),
                        ),
                      );
                      QuestionCubit.get(context).updateQuestion(
                        model: QuestionModel(
                          date: widget.model.date,
                          body: widget.model.body,
                          askerUid: widget.model.askerUid,
                          answersCount: widget.model.answersCount + 1,
                          answers: list,
                          isBanned: widget.model.isBanned,
                        ),
                        context: context,
                        id: widget.model.id!,
                        message: '',
                      );
                    } else {
                      showSnackBar(context, S.of(context).comment_error);
                    }
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: appColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(180 * 3.1415927 / 180),
                        child: Icon(
                          Icons.send,
                          color: whiteColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: controller,
                minLines: 1,
                maxLines: 15,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: appColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: appColor),
                  ),
                  hintText: S.of(context).add_answer,
                  hintStyle: TextStyle(
                    color: blackColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
