import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/settings/presentation/views/contact_us_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class AfterRequestHintWidget extends StatelessWidget {
  const AfterRequestHintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              color: Colors.amber,
              size: 30,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              S.of(context).after_request_profits_hint,
              style: TextStyles.style14.copyWith(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            customButton(
              onPressed: () {
                navigateTo(context, const ContactUsScreen());
              },
              lable: S.of(context).contactUs,
            ),
          ],
        ),
      ),
    );
  }
}
