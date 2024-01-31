import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/generated/l10n.dart';

import '../gym_subcribers_screen.dart';
import 'gym_container_info_widget.dart';

class GymRowInfoWidget extends StatelessWidget {
  const GymRowInfoWidget({super.key, required this.model});
  final GymModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        children: [
          GymContainerInfoWidget(
            onPressed: () {
              openLocation(
                lat: model.location.latitude,
                long: model.location.longitude,
              );
            },
            lable: S.of(context).location,
            value: '',
            icon: Icons.location_on_outlined,
            color: appColor,
          ),
          GymContainerInfoWidget(
            onPressed: () {},
            lable: S.of(context).money,
            value: model.price.toString(),
            icon: Icons.attach_money_outlined,
            color: appColor,
          ),
          GymContainerInfoWidget(
            onPressed: () {
              navigateTo(context, const GymSubcribersScreen());
            },
            lable: S.of(context).subcribers,
            value: model.subcribersCount.toString(),
            icon: Icons.people_outline,
            color: appColor,
          )
        ],
      ),
    );
  }
}
