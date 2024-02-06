import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class AdminUserContainerWidget extends StatelessWidget {
  const AdminUserContainerWidget({
    super.key,
    required this.lable,
    this.icon = Ionicons.person,
    required this.color,
    required this.onPressed,
  });
  final String lable;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 105,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: appColor.withOpacity(
            0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: whiteColor,
                size: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 50,
                ),
                child: Text(
                  lable,
                  style: TextStyles.style12.copyWith(
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
