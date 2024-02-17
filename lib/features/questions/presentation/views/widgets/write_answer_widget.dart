// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/show_dialog.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/manager/answer_cubit/answer_cubit.dart';
import 'package:tamrini/features/questions/presentation/manager/answer_cubit/answer_states.dart';
import 'package:tamrini/generated/l10n.dart';

class WriteAnswerWidget extends StatefulWidget {
  const WriteAnswerWidget(
      {super.key, required this.model, required this.token});
  final QuestionModel model;
  final String token;

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
    return BlocConsumer<AnswerCubit, AnswerStates>(
      listener: (context, state) {
        if (state is SucessUpdateAnswerState) {
          controller.clear();
          Navigator.pop(context);
        }
        if (state is ErrorUpdateAnswerState) {
          showSnackBar(context, state.message);
        }
        if (state is LoadingAnswerState) {
          showLoaderDialog(context);
        }
      },
      builder: (context, state) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              if (controller.text != '')
                GestureDetector(
                  onTap: () async {
                    if (await InternetConnectionChecker().hasConnection) {
                      if (controller.text == '') {
                      } else {
                        AnswerCubit.get(context).addNewAnswer(
                          answer: controller.text,
                          model: widget.model,
                          id: widget.model.id!,
                          token: widget.token,
                        );
                        setState(() {});
                      }
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
