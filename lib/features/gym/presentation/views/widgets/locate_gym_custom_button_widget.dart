import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/pick_location_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class LocateGymCustomButtonWidget extends StatelessWidget {
  const LocateGymCustomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        navigateTo(context, const PickLocationScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CacheHelper.getData(key: 'latmap') == null
              ? Icons.location_on_rounded
              : Icons.join_right_rounded),
          const SizedBox(
            width: 10,
          ),
          Text(S.of(context).locate_gym),
        ],
      ),
    );
  }
}
