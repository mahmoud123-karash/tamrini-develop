import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/proten_calculator_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottom_text.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class SignupContent extends StatefulWidget {
  const SignupContent({Key? key}) : super(key: key);

  @override
  State<SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<SignupContent>
    with TickerProviderStateMixin {
  TextEditingController email2Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;
  bool agree = false;

  Gender gender = Gender.Male;

  String code = '964';

  Widget inputField(String hint, IconData iconData,
      {TextInputType? type, required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.sp, vertical: 8.sp),
      child: SizedBox(
        height: 50,
        width: 250.w,
        child: TextFormField(
          maxLines: 1,
          enableInteractiveSelection: true,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'cairo'),
          controller: controller,
          textAlignVertical: TextAlignVertical.bottom,
          keyboardType: type,
          obscureText: iconData == Ionicons.lock_closed_outline ? true : false,
          decoration: InputDecoration(
            hintMaxLines: 1,
            helperMaxLines: 1,
            errorMaxLines: 1,
            border: const UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white),
            prefixIcon: Icon(iconData, color: Colors.white),
            suffix: iconData == Ionicons.call_outline
                ? StatefulBuilder(builder: (context, setState) {
                    return InkWell(
                      onTap: () {
                        showCountryPicker(
                          countryListTheme: CountryListThemeData(
                            searchTextStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'cairo',
                              color: Colors.black,
                            ),
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'cairo',
                              color: Colors.grey,
                            ),
                            inputDecoration: InputDecoration(
                              counterStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'cairo',
                                color: Colors.black,
                              ),

                              labelStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'cairo',
                                color: Colors.black,
                              ),
                              prefixIcon: const Icon(
                                Ionicons.search_outline,
                                color: Colors.black38,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              // filled: true,
                              // fillColor: Colors.white,

                              hintText: 'البلد',
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'cairo',
                                color: Colors.grey,
                              ),
                            ),
                          ),

                          context: context,
                          showPhoneCode:
                              true, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            code = country.phoneCode;
                            print('Select country: ${country.phoneCode}');
                            setState(() {});
                          },
                        );
                      },
                      child: Text(
                        '+$code',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'cairo',
                          color: Colors.white,
                        ),
                      ),
                    );
                  })
                : null,
          ),
        ),
      ),
    );
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: Consumer<UserProvider>(builder: (context, _, child) {
        return ElevatedButton(
          onPressed: () async {
            if (title == 'تسجيل') {
              if (email2Controller.text.isNotEmpty &&
                  password2Controller.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty &&
                  confirmPasswordController.text.isNotEmpty &&
                  userNameController.text.isNotEmpty &&
                  ageController.text.isNotEmpty) {
                if (phoneController.text.length < 9) {
                  Fluttertoast.showToast(
                    msg: "الرجاء التأكد من رقم الهاتف",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  return;
                }
                if (password2Controller.text ==
                        confirmPasswordController.text &&
                    agree) {
                  if (phoneController.text.toString()[0] == '0') {
                    phoneController.text =
                        phoneController.text.toString().replaceFirst('0', '');
                  }
                  _.signUp(
                    email: email2Controller.text.trim(),
                    password: password2Controller.text,
                    name: nameController.text,
                    phone: '+$code-${phoneController.text}',
                    username: userNameController.text,
                    age: int.parse(ageController.text),
                    gender: gender.name,
                    role: "user",
                  );
                } else if (password2Controller.text ==
                        confirmPasswordController.text &&
                    !agree) {
                  Fluttertoast.showToast(
                    msg: 'من فضلك قم بالموافقة على الشروط والاحكام',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'كلمة المرور غير متطابقة',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              } else {
                Fluttertoast.showToast(
                  msg: 'من فضلك ادخل جميع البيانات',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            // padding: const EdgeInsets.all(8),
            backgroundColor: Colors.grey[700],
            shape: const StadiumBorder(),
            elevation: 8,
            shadowColor: Colors.black87,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Text(
              title,
              // maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'cairo',
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    // ChangeScreenAnimation.dispose();

    confirmPasswordController.dispose();
    email2Controller.dispose();

    password2Controller.dispose();
    nameController.dispose();
    phoneController.dispose();
    userNameController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    createAccountContent = [
      const SizedBox(
        height: 20,
      ),
      inputField('الإسم بالكامل', Ionicons.person_outline,
          controller: nameController),
      inputField('إسم المستخدم', Ionicons.person_outline,
          controller: userNameController),
      inputField('البريد الإلكتروني', Ionicons.mail_outline,
          controller: email2Controller),
      inputField('رقم الهاتف', Ionicons.call_outline,
          type: TextInputType.phone, controller: phoneController),
      inputField('كلمة المرور', Ionicons.lock_closed_outline,
          controller: password2Controller),
      inputField('تأكيد كلمة المرور', Ionicons.lock_closed_outline,
          controller: confirmPasswordController),
      inputField('العمر', Ionicons.calendar_outline,
          type: TextInputType.phone, controller: ageController),
      StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Row(
            children: [
              Row(
                children: [
                  Radio(
                    value: Gender.Male,
                    groupValue: gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'ذكر',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Radio(
                    value: Gender.Female,
                    groupValue: gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'أنثى',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      //agree to terms and conditions
      StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Row(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (bool? value) {
                      setState(() {
                        agree = value!;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        const Text(
                          'أوافق على',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launchUrl(
                              Uri.parse(
                                  'https://www.privacypolicygenerator.info/live.php?token=MsmKdi4pne1dYTITIsaOPEXQh0zwVN1t'),
                            );
                          },
                          child: const Text(
                            'الشروط والأحكام',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     launchUrl(
                        //       Uri.parse(
                        //           'https://www.privacypolicygenerator.info/live.php?token=MsmKdi4pne1dYTITIsaOPEXQh0zwVN1t'),
                        //     );
                        //   },
                        //   child: const Text(
                        //     ' وسياسة الخصوصية',
                        //     style: TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w600,
                        //       color: Colors.white,
                        //       decoration: TextDecoration.underline,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      loginButton('تسجيل'),
      const Center(
          child: BottomText(text1: 'لديك حساب؟ ', text2: 'تسجيل دخول')),
      const SizedBox(
        height: 20,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20, top: 200),
      child: SizedBox(
        // height: MediaQuery.of(context).size.height,
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
                children: createAccountContent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
