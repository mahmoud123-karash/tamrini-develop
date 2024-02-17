import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_cubit.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_states.dart';
import 'swiper_banner_widget.dart';

class BannerSwiperWidget extends StatelessWidget {
  const BannerSwiperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerStates>(
      builder: (context, state) {
        if (state is SucessGetBannersState) {
          if (state.list.isEmpty) {
            return Container();
          }
          return SwiperBannerWidget(list: state.list);
        } else {
          return Container();
        }
      },
    );
  }
}
