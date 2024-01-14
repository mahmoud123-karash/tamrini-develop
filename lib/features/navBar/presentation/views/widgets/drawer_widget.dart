import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer_list_tile_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      elevation: 0,
      width: width / 1.4,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Intl.getCurrentLocale() == 'ar'
              ? const Radius.circular(60)
              : const Radius.circular(0),
          bottomLeft: Intl.getCurrentLocale() == 'ar'
              ? const Radius.circular(20)
              : const Radius.circular(0),
          bottomRight: Intl.getCurrentLocale() == 'en'
              ? const Radius.circular(20)
              : const Radius.circular(0),
          topRight: Intl.getCurrentLocale() == 'en'
              ? const Radius.circular(60)
              : const Radius.circular(0),
        ),
      ),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Image.asset(
                Assets.imagesLogo,
                width: 130.w,
                height: 130.h,
              ),
              DrawerListTileWidget(
                isSelected: false,
                onPressed: () {
                  navigateTo(context, const ProfileScreen());
                },
                icon: Ionicons.person,
                lable: S.of(context).profile,
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
