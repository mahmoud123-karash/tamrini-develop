import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/input_text_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../login_screen.dart';
import 'agree_privacy_row_widget.dart';
import 'bottom_text.dart';
import 'gender_row_widget.dart';
import 'register_custom_buider_button.dart';

class SignupContent extends StatefulWidget {
  const SignupContent({Key? key}) : super(key: key);

  @override
  State<SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<SignupContent>
    with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    confirmPasswordController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    CacheHelper.removeData(key: 'privacy');
    CacheHelper.removeData(key: 'gender');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20, top: 200),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.grey.shade700.withOpacity(0.7)),
              child: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextFielsWidget(
                      autovalidateMode: autovalidateMode,
                      hint: S.of(context).name,
                      iconData: Ionicons.person_outline,
                      type: TextInputType.text,
                      controller: nameController,
                    ),
                    InputTextFielsWidget(
                      autovalidateMode: autovalidateMode,
                      hint: S.of(context).email,
                      iconData: Ionicons.mail_outline,
                      type: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    InputTextFielsWidget(
                      autovalidateMode: autovalidateMode,
                      hint: S.of(context).phone,
                      iconData: Ionicons.call_outline,
                      type: TextInputType.phone,
                      controller: phoneController,
                    ),
                    InputTextFielsWidget(
                      autovalidateMode: autovalidateMode,
                      hint: S.of(context).pass,
                      iconData: Ionicons.lock_closed_outline,
                      type: TextInputType.text,
                      controller: passwordController,
                    ),
                    InputTextFielsWidget(
                      autovalidateMode: autovalidateMode,
                      hint: S.of(context).confirmpass,
                      iconData: Ionicons.lock_closed_outline,
                      type: TextInputType.text,
                      controller: confirmPasswordController,
                    ),
                    InputTextFielsWidget(
                      autovalidateMode: autovalidateMode,
                      hint: S.of(context).age,
                      iconData: Ionicons.calendar_outline,
                      type: TextInputType.phone,
                      controller: ageController,
                    ),
                    const GenderRowWidget(),
                    const AgreePrivacyRowWidget(),
                    RegisterCustomBuilderButton(
                      onPressed: () {
                        String gender =
                            CacheHelper.getData(key: 'gender') ?? '';
                        bool privacy =
                            CacheHelper.getData(key: 'privacy') ?? false;

                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          if (phoneController.text.length < 9) {
                            showSnackBar(context, S.of(context).phoneLenght);
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            showSnackBar(context, S.of(context).passConfirm);
                          } else if (gender == '') {
                            showSnackBar(context, S.of(context).genderConfirm);
                          } else if (privacy == false) {
                            showSnackBar(context, S.of(context).privacyConfirm);
                          } else {
                            RegisterCubit.get(context).registerUser(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              age: int.parse(ageController.text),
                              gender: gender,
                              password: passwordController.text,
                            );
                          }
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                    ),
                    Center(
                      child: BottomText(
                        text1: S.of(context).haveacount,
                        text2: S.of(context).login,
                        onPressed: () {
                          navigateToAndFinish(context, const LoginScreen());
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
