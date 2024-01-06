import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

import 'show_gym_on_map_widget.dart';

class GymCustomButtonsWidget extends StatelessWidget {
  const GymCustomButtonsWidget(
      {super.key, required this.lat, required this.long});
  final double lat, long;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$lat,$long';
                openUri(url: Uri.parse(googleUrl));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                ),
                child: const ShowGymOnMapWWidget(),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appColor),
                  color: appColor,
                ),
                child: Center(
                  child: Text(
                    S.of(context).sub,
                    style: TextStyles.style17.copyWith(color: whiteColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
