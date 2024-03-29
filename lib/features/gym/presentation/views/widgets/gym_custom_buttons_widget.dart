import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../payment/presentation/views/gym_sub_payment_screen.dart';
import 'show_gym_on_map_widget.dart';

class GymCustomButtonsWidget extends StatelessWidget {
  const GymCustomButtonsWidget({
    super.key,
    required this.lat,
    required this.long,
    required this.gymId,
    required this.count,
    required this.price,
    required this.profits,
  });
  final double lat, long;
  final String gymId;
  final int count;
  final num price, profits;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            if (userType != 'admin')
              Expanded(
                child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  color: Colors.white,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: appColor,
                    ),
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
            if (userType != 'gym owner' && userType != 'admin')
              Expanded(
                child: MaterialButton(
                  color: appColor,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () {
                    navigateTo(
                      context,
                      GymSubPaymentScreen(
                        subId: '',
                        gymId: gymId,
                        count: count,
                        price: price,
                        profits: profits,
                      ),
                    );
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
