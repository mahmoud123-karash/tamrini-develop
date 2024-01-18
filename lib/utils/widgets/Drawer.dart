import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/provider/trainer_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/Home_screen.dart';
import 'package:tamrini/screens/courses_screen/courses_home_screen.dart';
import 'package:tamrini/screens/courses_screen/diet_home_screen.dart';
import 'package:tamrini/screens/courses_screen/followUp_screen.dart';
import 'package:tamrini/screens/courses_screen/supplements_screen.dart';
import 'package:tamrini/screens/setting_screens/about_app_screen.dart';
import 'package:tamrini/features/settings/presentation/views/contact_us_screen.dart';
import 'package:tamrini/screens/setting_screens/control_screen.dart';
import 'package:tamrini/screens/setting_screens/settings_screen.dart';
import 'package:tamrini/screens/trainer_screens/pending_trainees_screen.dart';
import 'package:tamrini/screens/trainer_screens/pending_trainers_screen.dart';
import 'package:tamrini/screens/trainer_screens/supplements_home_screen.dart';
import 'package:tamrini/screens/trainer_screens/trainees_screen.dart';
import 'package:tamrini/screens/trainer_screens/trainer_home_screen.dart';
import 'package:tamrini/utils/cache_helper.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/login_screen/login_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    CacheHelper.init();
    super.initState();
  }

  // List<Widget> icons = [
  //   // SvgPicture.asset("assets/images/twitter_white.svg" ,),
  //   Image.network(
  //     "https://www.iconsdb.com/icons/preview/white/twitter-xxl.png",
  //     width: 25,
  //   ),
  //   Icon(Icons.facebook, color: Colors.white),
  //   SvgPicture.asset(
  //     "assets/images/google-play.svg",
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        // listener: (context, state) {},
        builder: (context, __, child) => Drawer(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 150.w,
                        height: 70.h,
                      ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),

                      myListTielStatic(
                        "الرئيسية",
                        Icon(
                          Icons.home,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        () async {
                          ToAndFinish(const HomeScreen());
                        },
                        true,
                      ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),
                      !__.isLogin
                          ? myListTielStatic(
                              "تسجيل الدخول",
                              Icon(
                                Icons.login,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              ToAndFinish(const LoginScreen());
                            }, false)
                          : Container(),

                      __.isAdmin && __.isLogin
                          ? myListTielStatic(
                              "التحكم بالتطبيق",
                              Icon(
                                Icons.manage_accounts_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ), () {
                              To(const AdminControlScreen());
                            }, false)
                          : Container(),

                      // SizedBox(
                      //   height: 15.h,
                      // ),
                      __.isCaptain || __.isAdmin
                          ? Container()
                          : myListTielStatic(
                              "الكورسات",
                              Icon(
                                Icons.golf_course_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              __.isLogin
                                  ? {
                                      __.user.isSubscribedToTrainer
                                          ? {
                                              Provider.of<TraineeProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchAndSetTraineeData(),
                                              To(const CoursesHomeScreen())
                                            }
                                          : AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.info,
                                              animType: AnimType.bottomSlide,
                                              title: 'تنبيه',
                                              desc:
                                                  'يجب عليك الاشتراك عند مدرب اولا لمشاهدة الكورسات',
                                              btnCancelOnPress: () {
                                                // pop();
                                              },
                                              btnOkOnPress: () {
                                                Provider.of<TrainerProvider>(
                                                        context,
                                                        listen: false)
                                                    .fetchAndSetTrainers();
                                                To(const TrainerHomeScreen());
                                              },
                                            ).show()
                                    }
                                  : AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.bottomSlide,
                                      title: 'تنبيه',
                                      desc:
                                          'يجب عليك تسجيل الدخول اولا للمتابعة',
                                      btnCancelOnPress: () {
                                        // pop();
                                      },
                                      btnOkOnPress: () {
                                        To(const LoginScreen());
                                      },
                                    ).show();
                            }, false),
                      __.isCaptain || __.isAdmin
                          ? Container()
                          : myListTielStatic(
                              "المكملات الغذائية",
                              Icon(
                                Icons.local_drink_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              __.isLogin
                                  ? {
                                      __.user.isSubscribedToTrainer
                                          ? {
                                              Provider.of<TraineeProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchAndSetTraineeData(),
                                              To(const SupplementsScreen())
                                            }
                                          : AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.info,
                                              animType: AnimType.bottomSlide,
                                              title: 'تنبيه',
                                              desc:
                                                  'يجب عليك الاشتراك عند مدرب اولا لمشاهدة الكورسات',
                                              btnCancelOnPress: () {
                                                // pop();
                                              },
                                              btnOkOnPress: () {
                                                Provider.of<TrainerProvider>(
                                                        context,
                                                        listen: false)
                                                    .fetchAndSetTrainers();
                                                To(const TrainerHomeScreen());
                                              },
                                            ).show()
                                    }
                                  : AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.bottomSlide,
                                      title: 'تنبيه',
                                      desc:
                                          'يجب عليك تسجيل الدخول اولا للمتابعة',
                                      btnCancelOnPress: () {
                                        // pop();
                                      },
                                      btnOkOnPress: () {
                                        To(const LoginScreen());
                                      },
                                    ).show();
                            }, false),
                      __.isAdmin && __.isLogin
                          ? myListTielStatic(
                              "المدربين المعلقين",
                              Icon(
                                Icons.access_time_filled_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              Provider.of<TrainerProvider>(context,
                                      listen: false)
                                  .fetchAndSetPendingTrainers();
                              To(const PendingTrainersScreen());
                            }, false)
                          : Container(),

                      __.isCaptain
                          ? myListTielStatic(
                              "المشتركين ",
                              Icon(
                                Icons.sports_handball_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              Provider.of<TraineeProvider>(context,
                                      listen: false)
                                  .fetchAndSetTrainees();
                              To(const TraineesScreen());
                            }, false)
                          : Container(),

                      __.isCaptain
                          ? myListTielStatic(
                              "المشتركين المعلقين",
                              Icon(
                                Icons.access_time_filled_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              Provider.of<TraineeProvider>(context,
                                      listen: false)
                                  .fetchAndSetPendingTrainees();
                              To(const PendingTraineesScreen());
                            }, false)
                          : Container(),

                      __.isCaptain || __.isAdmin
                          ? Container()
                          : myListTielStatic(
                              "النظام الغذائي",
                              Icon(
                                Icons.emoji_food_beverage_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              __.isLogin
                                  ? {
                                      __.user.isSubscribedToTrainer
                                          ? {
                                              Provider.of<TraineeProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchAndSetTraineeData(),
                                              To(const DietHomeScreen())
                                            }
                                          : AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.info,
                                              animType: AnimType.bottomSlide,
                                              title: 'تنبيه',
                                              desc:
                                                  'يجب عليك الاشتراك عند مدرب اولا لمشاهدة النظام الغذائي الخاص بك',
                                              btnCancelOnPress: () {
                                                // pop();
                                              },
                                              btnOkOnPress: () {
                                                To(const TrainerHomeScreen());
                                              },
                                            ).show()
                                    }
                                  : AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.bottomSlide,
                                      title: 'تنبيه',
                                      desc:
                                          'يجب عليك تسجيل الدخول اولا للمتابعة',
                                      btnCancelOnPress: () {
                                        // pop();
                                      },
                                      btnOkOnPress: () {
                                        To(const LoginScreen());
                                      },
                                    ).show();
                            }, false),

                      __.isCaptain || __.isAdmin
                          ? Container()
                          : myListTielStatic(
                              "المتابعة",
                              Icon(
                                Icons.follow_the_signs_sharp,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              __.isLogin
                                  ? {
                                      __.user.isSubscribedToTrainer
                                          ? {
                                              Provider.of<TraineeProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchAndSetTraineeData(),
                                              To(const FollowUpScreen())
                                            }
                                          : AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.info,
                                              animType: AnimType.bottomSlide,
                                              title: 'تنبيه',
                                              desc:
                                                  'يجب عليك الاشتراك عند مدرب اولا لمشاهدة النظام الغذائي الخاص بك',
                                              btnCancelOnPress: () {
                                                // pop();
                                              },
                                              btnOkOnPress: () {
                                                To(const TrainerHomeScreen());
                                              },
                                            ).show()
                                    }
                                  : AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.bottomSlide,
                                      title: 'تنبيه',
                                      desc:
                                          'يجب عليك تسجيل الدخول اولا للمتابعة',
                                      btnCancelOnPress: () {
                                        // pop();
                                      },
                                      btnOkOnPress: () {
                                        To(const LoginScreen());
                                      },
                                    ).show();
                            }, false),

                      myListTielStatic(
                          "الإعدادات",
                          Icon(
                            Icons.settings,
                            color: Theme.of(context).iconTheme.color,
                          ), () async {
                        To(SettingsScreen());
                      }, false),

                      myListTielStatic(
                          "عن التطبيق",
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).iconTheme.color,
                          ), () async {
                        To(const AboutAppScreen());
                      }, false),

                      myListTielStatic(
                          "تواصل معنا",
                          Icon(
                            Icons.call,
                            color: Theme.of(context).iconTheme.color,
                          ), () async {
                        To(const ContactUsScreen());
                      }, false),

                      myListTielStatic(
                          "تقييم التطبيق",
                          Icon(
                            Icons.star,
                            color: Theme.of(context).iconTheme.color,
                          ), () async {
                        Platform.isAndroid
                            ? await canLaunchUrl(Uri.parse(
                                    "https://play.google.com/store/apps/details?id=com.tamrini1.com&hl=ar&gl=US"))
                                ? await launchUrl(
                                    Uri.parse(
                                        "https://play.google.com/store/apps/details?id=com.tamrini1.com&hl=ar&gl=US"),
                                    mode: LaunchMode.externalApplication)
                                : throw 'Could not launch https://play.google.com/store/apps/details?id=com.tamrini1.com&hl=ar&gl=US'
                            : await canLaunchUrl(
                                Uri.parse(
                                    "https://apps.apple.com/us/app/%D8%AA%D8%B7%D8%A8%D9%8A%D9%82-%D8%AA%D9%85%D8%B1%D9%8A%D9%86%D9%8A/id1571336937"),
                              )
                                ? await launchUrl(
                                    Uri.parse(
                                        "https://apps.apple.com/us/app/%D8%AA%D8%B7%D8%A8%D9%8A%D9%82-%D8%AA%D9%85%D8%B1%D9%8A%D9%86%D9%8A/id1571336937"),
                                    mode: LaunchMode.externalApplication)
                                : throw 'Could not launch https://apps.apple.com/us/app/%D8%AA%D8%B7%D8%A8%D9%8A%D9%82-%D8%AA%D9%85%D8%B1%D9%8A%D9%86%D9%8A/id1571336937';

                        // To(const LoginScreen());
                      }, false),
                      __.isLogin
                          ? myListTielStatic(
                              "تسجيل الخروج",
                              Icon(
                                Icons.logout,
                                color: Theme.of(context).iconTheme.color,
                              ), () async {
                              __.logOut();
                              pop();
                              Fluttertoast.showToast(
                                  msg: "تم تسجيل الخروج بنجاح");
                            }, false)
                          : Container(),

                      //

                      // myListTielStatic(
                      //   "المفضلة",
                      //   Icon(Icons.favorite, color: Colors.white),
                      //   () async {
                      //     Navigator.pop(context);
                      //
                      //     // await SharedPrefHelper.sharedPrefHelper
                      //     //     .initSharedPrefs();
                      //     // cubit.getAllFavouriteProducts();
                      //     // To(FavoriteScreen());
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
