import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/features/auth/presentation/manager/reset_cubit/reset_cubit.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/reset_button_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'input_text_field_widget.dart';

class ResetContentWidget extends StatefulWidget {
  const ResetContentWidget({super.key});

  @override
  State<ResetContentWidget> createState() => _ResetContentWidgetState();
}

class _ResetContentWidgetState extends State<ResetContentWidget> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.5,
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.grey.shade700.withOpacity(0.7)),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    InputTextFielsWidget(
                      autovalidateMode: autovalidateMode,
                      hint: S.of(context).resetEmail,
                      iconData: Ionicons.mail_outline,
                      type: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ResetButtonBuilderWidget(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              ResetCubit.get(context)
                                  .resetPass(email: emailController.text);
                            } else {
                              autovalidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
