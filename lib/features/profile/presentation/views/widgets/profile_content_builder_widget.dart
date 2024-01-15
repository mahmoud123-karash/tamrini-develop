import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_states.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_content_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/profile_message_builder_widget.dart';

class ProfileContentBuilderWidget extends StatelessWidget {
  const ProfileContentBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is SucessGetProfileState) {
          return ProfileContentWidget(model: state.model);
        } else if (state is ErrorGetProfileState) {
          return ProfileMessageBuilderWidget(message: state.message);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
