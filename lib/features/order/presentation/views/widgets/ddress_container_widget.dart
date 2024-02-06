import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class AddressContainerWidget extends StatelessWidget {
  const AddressContainerWidget({super.key, required this.address});
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greyColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(
              Icons.location_history_outlined,
              color: appColor,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              S.of(context).address,
              style: TextStyles.style17.copyWith(
                fontWeight: FontWeight.bold,
                color: appColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              address,
              style: TextStyles.style16Bold.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
