import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ProfileListTileWidget extends StatelessWidget {
  const ProfileListTileWidget(
      {super.key,
      required this.onPressed,
      required this.lable,
      required this.icon});
  final VoidCallback onPressed;
  final String lable;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      child: ListTile(
        onTap: onPressed,
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: appColor.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon),
          ),
        ),
        title: Text(
          lable,
          style: TextStyles.style13.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
      ),
    );
  }
}
