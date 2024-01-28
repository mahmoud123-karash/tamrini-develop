import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class AdminListTileWidget extends StatelessWidget {
  const AdminListTileWidget({
    super.key,
    required this.lable,
    required this.icon,
    required this.onPressed,
  });
  final String lable;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: ListTile(
        tileColor: greyColor.withOpacity(0.3),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: onPressed,
        title: Text(
          lable,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(icon),
        trailing: const Icon(
          Icons.arrow_forward_ios_sharp,
        ),
      ),
    );
  }
}
