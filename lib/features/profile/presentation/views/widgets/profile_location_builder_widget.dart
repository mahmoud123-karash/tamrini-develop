import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/presentation/manager/location_cubit/location_cubit.dart';
import 'package:tamrini/features/profile/presentation/manager/location_cubit/location_states.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/value_icon_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../../core/cache/shared_preference.dart';

class ProfileLocationBuilderWidget extends StatelessWidget {
  const ProfileLocationBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {
        if (state is LocationChangedErrorState) {
          showSnackBar(context, state.message);
        }
        if (state is LocationChangedSuccessState) {
          showSnackBar(context, S.of(context).success_update_location);
        }
      },
      builder: (context, state) {
        if (state is LocationChangedSuccessState) {
          return ValueIconRowWidget(
            state: state,
            value: state.message,
            icon: Icons.location_on_rounded,
          );
        } else {
          return ValueIconRowWidget(
            state: state,
            value: CacheHelper.getData(key: 'address') ?? '',
            icon: Icons.location_on_rounded,
          );
        }
      },
    );
  }
}
