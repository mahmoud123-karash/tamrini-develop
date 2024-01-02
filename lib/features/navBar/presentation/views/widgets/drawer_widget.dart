import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              myListTielStatic(
                "الرئيسية",
                Icon(
                  Icons.home,
                  color: Theme.of(context).iconTheme.color,
                ),
                () async {},
                true,
              ),
              myListTielStatic(
                  "الإعدادات",
                  Icon(
                    Icons.settings,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  () async {},
                  false),
              myListTielStatic(
                  "عن التطبيق",
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  () async {},
                  false),
              myListTielStatic(
                  "تواصل معنا",
                  Icon(
                    Icons.call,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  () async {},
                  false),
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
              myListTielStatic(
                  "تسجيل الخروج",
                  Icon(
                    Icons.logout,
                    color: Theme.of(context).iconTheme.color,
                  ), () async {
                pop();
                Fluttertoast.showToast(msg: "تم تسجيل الخروج بنجاح");
              }, false)
            ],
          ),
        ),
      ),
    );
  }
}
