import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/profile/presentation/manager/location_cubit/location_cubit.dart';
import 'package:tamrini/features/profile/presentation/manager/location_cubit/location_states.dart';
import 'package:tamrini/generated/l10n.dart';

class ValueIconRowWidget extends StatelessWidget {
  const ValueIconRowWidget({
    super.key,
    required this.value,
    required this.icon,
    this.state,
  });
  final String value;
  final IconData icon;
  final LocationStates? state;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: appColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: width / 2),
            child: Text(
              value,
              style: TextStyles.style14,
              maxLines: 1,
            ),
          ),
          const Spacer(),
          if (icon == Icons.location_on_rounded)
            state is LocationChangedLoadingState
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: () {
                      CacheHelper.removeData(key: 'address');
                      LocationCubit.get(context).getLocationAddress();
                    },
                    child: Text(
                      S.of(context).update,
                      style: TextStyles.style12,
                    ),
                  ),
        ],
      ),
    );
  }
}
