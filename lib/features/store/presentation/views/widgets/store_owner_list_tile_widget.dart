import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class StoreOwnerListTileWidget extends StatelessWidget {
  const StoreOwnerListTileWidget(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.lable});
  final VoidCallback onTap;
  final IconData icon;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        onTap: onTap,
        tileColor: appColor.withOpacity(0.2),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        title: Text(lable),
        leading: Icon(
          icon,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
      ),
    );
  }
}
