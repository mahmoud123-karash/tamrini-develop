import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/settings/presentation/views/contact_us_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class BanGymContainerWidget extends StatelessWidget {
  const BanGymContainerWidget({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Colors.red,
                size: 30,
              ),
              Text(
                message,
                style: TextStyles.style16Bold.copyWith(
                  color: Colors.red,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: MaterialButton(
                  color: appColor,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () {
                    navigateTo(context, const ContactUsScreen());
                  },
                  child: Text(
                    S.of(context).contact_u,
                    style: TextStyles.style14.copyWith(
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
