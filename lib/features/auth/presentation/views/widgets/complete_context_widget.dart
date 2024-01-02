import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/complete_cubit/complete_cubit.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/complete_custom_button_buider_widget.dart';
import 'package:tamrini/features/auth/presentation/views/widgets/gender_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'agree_privacy_row_widget.dart';
import 'input_text_field_widget.dart';

class CompleteContentWidget extends StatefulWidget {
  const CompleteContentWidget({
    super.key,
    required this.name,
    required this.email,
    required this.uid,
  });
  final String name, email, uid;

  @override
  State<CompleteContentWidget> createState() => _CompleteContentWidgetState();
}

class _CompleteContentWidgetState extends State<CompleteContentWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    nameController.text = widget.name;
    emailController.text = widget.email;
    CacheHelper.removeData(key: 'privacy');
    CacheHelper.removeData(key: 'gender');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    CompleteCubit.get(context).signOut();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                        type: TextInputType.none,
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
                        hint: S.of(context).age,
                        iconData: Ionicons.calendar_outline,
                        type: TextInputType.phone,
                        controller: ageController,
                      ),
                      const GenderRowWidget(),
                      const AgreePrivacyRowWidget(),
                      CompleteCustomBuilderWidget(
                        onPressed: () {
                          String gender =
                              CacheHelper.getData(key: 'gender') ?? '';
                          bool privacy =
                              CacheHelper.getData(key: 'privacy') ?? false;
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (phoneController.text.length < 9) {
                              showSnackBar(context, S.of(context).phoneLenght);
                            } else if (gender == '') {
                              showSnackBar(
                                  context, S.of(context).genderConfirm);
                            } else if (privacy == false) {
                              showSnackBar(
                                  context, S.of(context).privacyConfirm);
                            } else {
                              CompleteCubit.get(context).createUser(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                age: int.parse(ageController.text),
                                gender: gender,
                                uid: widget.uid,
                              );
                            }
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
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
      ),
    );
  }
}
