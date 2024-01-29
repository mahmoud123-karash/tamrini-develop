import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_states.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/edit_profile_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class EditProfileCustomButtonBuilderWidget extends StatelessWidget {
  const EditProfileCustomButtonBuilderWidget(
      {super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is SucessGetProfileState) {
          Navigator.pop(context);
          showSnackBar(context, S.of(context).success_update_profile);
        }
        if (state is ErrorGetProfileState) {
          ProfileCubit.get(context).getProfile();
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetProfileState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return CustomEditProfileButtonWidget(
            onPressed: onPressed,
          );
        }
      },
    );
  }
}
