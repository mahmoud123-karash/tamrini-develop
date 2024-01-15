import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsListTileWidget extends StatelessWidget {
  const SettingsListTileWidget(
      {super.key,
      required this.iconData,
      required this.lable,
      required this.onPressed});
  final IconData iconData;
  final String lable;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        lable,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        iconData,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
      ),
    );
  }
}
