import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:tamrini/features/auth/presentation/views/reset_password_screen.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/input_text_field_widget.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/login_custom_builder_widget.dart';
import 'package:tamrini/features/nav_bar/presentation/views/navbar_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../sign_up_screen.dart';
import 'bottom_text.dart';
import 'message_text_widget.dart';
import 'logs_login_widget.dart';
import 'or_divider_widget.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade700.withOpacity(0.7)),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 20),
                        InputTextFielsWidget(
                          autovalidateMode: autovalidateMode,
                          hint: S.of(context).email,
                          iconData: Ionicons.mail_outline,
                          type: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        InputTextFielsWidget(
                          autovalidateMode: autovalidateMode,
                          hint: S.of(context).pass,
                          iconData: Ionicons.lock_closed_outline,
                          controller: passwordController,
                          type: TextInputType.text,
                        ),
                        LoginCustomBuilderButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              LoginCubit.get(context).loginWithEmailAndPass(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            } else {
                              autovalidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          },
                        ),
                        const OrDividerWidge(),
                        const LogsLoginWidget(),
                        Center(
                          child: BottomText(
                            text1: S.of(context).create,
                            text2: S.of(context).create1,
                            onPressed: () {
                              navigateTo(
                                context,
                                const SignUpScreen(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MessageTextWidget(
                          label: S.of(context).forget,
                          onPressed: () {
                            navigateTo(
                              context,
                              const ResetPassScreen(),
                            );
                          },
                        ),
                        MessageTextWidget(
                          label: S.of(context).follow,
                          onPressed: () {
                            saveUserType('');
                            navigateToAndFinish(context, const NavBarScreen());
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
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
