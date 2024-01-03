import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/features/home/presentation/manager/swiper_cubit/swiper_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/swiper_cubit/swiper_states.dart';

import 'image_view_widget.dart';
import 'swiper_show_buttons_widget.dart';

class ExerciseAssetsViewWidget extends StatefulWidget {
  const ExerciseAssetsViewWidget({
    super.key,
    required this.images,
    this.player,
  });
  final List<String> images;
  final Widget? player;

  @override
  State<ExerciseAssetsViewWidget> createState() =>
      _ExerciseAssetsViewWidgetState();
}

class _ExerciseAssetsViewWidgetState extends State<ExerciseAssetsViewWidget> {
  @override
  void initState() {
    if (widget.player == null) {
      log('message');
    }
    log(widget.images.last);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    return BlocBuilder<SwiperCubit, SwiperStates>(
      builder: (context, state) {
        int cachedIndex = CacheHelper.getData(key: 'index') ?? 0;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Swiper(
                  scrollDirection: Axis.horizontal,
                  axisDirection: AxisDirection.right,
                  controller: SwiperCubit.get(context).swiperController,
                  physics: const NeverScrollableScrollPhysics(),
                  loop: false,
                  index: cachedIndex,
                  layout: SwiperLayout.CUSTOM,
                  customLayoutOption: CustomLayoutOption(
                    startIndex: -1,
                    stateCount: 3,
                  )
                    ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                    ..addTranslate([
                      const Offset(-370.0, -40.0),
                      const Offset(0.0, 0.0),
                      const Offset(370.0, -40.0)
                    ]),
                  itemWidth: double.infinity,
                  itemHeight: getHeight / 4,
                  onIndexChanged: (value) {
                    SwiperCubit.get(context).saveIndex(value);
                  },
                  itemBuilder: (context, index) {
                    return widget.player == null
                        ? ImageViewWidget(image: widget.images.first)
                        : widget.images.length == 1
                            ? checkVedioformat(widget.images) == ''
                                ? ImageViewWidget(image: widget.images.first)
                                : widget.player!
                            : index == 0
                                ? ImageViewWidget(image: widget.images.first)
                                : widget.player!;
                  },
                  itemCount: widget.images.length,
                ),
              ),
            ),
            if (widget.images.length == 2)
              SwiperShowButtonsWidget(index: cachedIndex),
          ],
        );
      },
    );
  }
}
