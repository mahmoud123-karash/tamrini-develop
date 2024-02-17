import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_cubit.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddBannerCustomBuilderWidget extends StatelessWidget {
  const AddBannerCustomBuilderWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerCubit, BannerStates>(
      listener: (context, state) {
        if (state is ErrorGetBannersState) {
          showSnackBar(context, state.message);
          BannerCubit.get(context).getData();
        }
        if (state is SucessGetBannersState) {
          showSnackBar(context, S.of(context).success_add_a);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetBannersState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(
            onPressed: onPressed,
            lable: S.of(context).add,
          );
        }
      },
    );
  }
}
