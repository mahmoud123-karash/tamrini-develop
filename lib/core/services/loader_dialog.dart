import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: Center(
      child: Image.asset(Assets.imagesLoading),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
