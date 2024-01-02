import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/utils/widgets/button_widget.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';
import 'package:tamrini/utils/widgets/textfield_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key, bool isReset = false}) : super(key: key);
  String oldPassword = '';
  String newPassword = '';
  String confirmNewPassword = '';
  bool isReset = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [adBanner()],
        appBar: globalAppBar("تغيير كلمة المرور"),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            isReset ? const SizedBox() : const SizedBox(height: 24),
            isReset
                ? const SizedBox()
                : TextFieldWidget(
                    label: 'كلمة المرور القديمة',
                    onChanged: (password) {
                      oldPassword = password;
                    },
                    text: '',
                    isPassword: true,
                  ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'كلمة المرور الجديدة',
              onChanged: (password) {
                newPassword = password;
              },
              text: '',
              isPassword: true,
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'تأكيد كلمة المرور الجديدة',
              onChanged: (password) {
                confirmNewPassword = password;
              },
              text: '',
              isPassword: true,
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'تغيير كلمة المرور',
              onClicked: () {
                if (!isReset) {
                  if (oldPassword == '' ||
                      newPassword == '' ||
                      confirmNewPassword == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade900,
                        content: const Text('الرجاء ملئ جميع الحقول'),
                      ),
                    );
                    return;
                  }
                  if (oldPassword !=
                      Provider.of<UserProvider>(context, listen: false)
                          .user
                          .password) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade900,
                        content: const Text('كلمة المرور القديمة غير صحيحة'),
                      ),
                    );
                    return;
                  }
                } else {
                  if (newPassword == '' || confirmNewPassword == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade900,
                        content: const Text('الرجاء ملئ جميع الحقول'),
                      ),
                    );
                    return;
                  }
                }

                if (newPassword.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red.shade900,
                      content:
                          const Text('كلمة المرور يجب أن تكون أكثر من 6 أحرف'),
                    ),
                  );
                  return;
                }

                if (newPassword != confirmNewPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red.shade900,
                      content: const Text('كلمة المرور غير متطابقة'),
                    ),
                  );
                  return;
                } else {
                  Provider.of<UserProvider>(context, listen: false)
                      .changePassword(newPassword);
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ));
  }
}
