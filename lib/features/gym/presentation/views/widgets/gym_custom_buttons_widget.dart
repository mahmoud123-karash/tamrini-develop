import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'show_gym_on_map_widget.dart';

class GymCustomButtonsWidget extends StatelessWidget {
  const GymCustomButtonsWidget(
      {super.key,
      required this.lat,
      required this.long,
      required this.gymId,
      required this.count});
  final double lat, long;
  final String gymId;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                color: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {
                  openLocation(lat: lat, long: long);
                },
                child: const ShowGymOnMapWWidget(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: MaterialButton(
                color: appColor,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {
                  SubscriberCubit.get(context)
                      .subUser(gymId: gymId, count: count);
                },
                child: Text(
                  S.of(context).sub,
                  style: TextStyles.style14.copyWith(
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
