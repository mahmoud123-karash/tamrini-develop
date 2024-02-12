import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class TraineeListTileWidget extends StatelessWidget {
  const TraineeListTileWidget(
      {super.key,
      required this.lable,
      required this.icon,
      required this.onTap});
  final String lable;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 0,
        ),
        onTap: onTap,
        tileColor: greyColor.withOpacity(0.2),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          lable,
          style: TextStyles.style14.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          icon,
          color: appColor,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_sharp,
          color: appColor,
        ),
      ),
    );
  }
}
