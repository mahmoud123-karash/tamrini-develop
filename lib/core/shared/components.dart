import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/utils/navigation_route.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

// GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
// GlobalKey<NavigatorState> get navigationKey => _navigationKey;

void navigateTo(context, route) => Navigator.push(
      context,
      createRoute(route),
    );

void navigateToAndFinish(context, route) => Navigator.pushAndRemoveUntil(
      context,
      createRoute(route),
      (route) => false,
    );

void showToast(
  String message, {
  ToastGravity? gravity = ToastGravity.BOTTOM,
}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: appColor,
    gravity: gravity,
    textColor: whiteColor,
    toastLength: Toast.LENGTH_SHORT,
  );
}

void showSnackBar(context, message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );

AppBar myAppBar(
  title, {
  List<Widget>? actions,
}) =>
    AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
      ),
      actions: actions,
    );

Widget searchField({
  required TextEditingController controller,
  required Function(String) onChanged,
}) =>
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Ionicons.search_outline,
            color: blackColor,
          ),
          hintText: S.of(navigationKey.currentContext!).search,
          hintStyle: TextStyle(
            color: blackColor,
            fontWeight: FontWeight.w600,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );

Widget loadingWidget() => Center(
      child: SizedBox(
        height: 80.h,
        child: Center(
          child: Image.asset(
            Assets.imagesLoading,
          ),
        ),
      ),
    );

AwesomeDialog logOutDialog(context) => AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.bottomSlide,
      title: S.of(context).log_out,
      desc: S.of(context).log_out_question,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        logOut(context);
      },
    );
