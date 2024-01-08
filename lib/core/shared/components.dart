import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/utils/navigation_route.dart';

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

AppBar myAppBar(title) => AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
      ),
    );
