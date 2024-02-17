import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_cubit.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_states.dart';
import 'package:tamrini/features/order/presentation/views/widgets/message_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'banner_list_view_widget.dart';

class BannerListViewBuilderWidget extends StatelessWidget {
  const BannerListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerStates>(
      builder: (context, state) {
        if (state is SucessGetBannersState) {
          if (state.list.isEmpty) {
            return MessageBuilderWidget(message: S.of(context).no_results);
          }
          return BannerListViewWidget(list: state.list);
        } else if (state is ErrorGetBannersState) {
          return MessageBuilderWidget(message: state.message);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
