import 'package:flutter/material.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/views/gym_details_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class SubscriptionGymDetailsWidget extends StatelessWidget {
  const SubscriptionGymDetailsWidget({super.key, required this.gym});
  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          gym.name,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            openLocation(
              lat: gym.location.latitude,
              long: gym.location.longitude,
            );
          },
          child: const Icon(Icons.location_on_rounded),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            navigateTo(context, GymDetailsScreen(gymId: gym.id));
          },
          child: Text(S.of(context).gym_details),
        )
      ],
    );
  }
}
