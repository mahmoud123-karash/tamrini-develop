import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class NameLocationTrainerWidget extends StatelessWidget {
  const NameLocationTrainerWidget(
      {super.key, required this.name, required this.address});
  final String name, address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).coach,
          style: TextStyles.style14,
        ),
        Text(
          name,
          style: TextStyles.style19,
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on_rounded,
              color: Colors.amber,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 150,
              ),
              child: Text(
                address,
                style: TextStyles.style14,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
