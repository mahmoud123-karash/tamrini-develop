import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/banner/data/models/banner_model/banner_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_banner_item_widget.dart';

class SwiperBannerWidget extends StatelessWidget {
  const SwiperBannerWidget({super.key, required this.list});
  final List<BannerModel> list;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return HoneBannerItemWidget(
            model: list[index],
          );
        },
        itemCount: list.length,
        itemWidth: width,
        itemHeight: 190.0,
        layout: SwiperLayout.CUSTOM,
        customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
          ..addRotate(
            [-45.0 / 180, 0.0, 45.0 / 180],
          )
          ..addTranslate(
            [
              const Offset(-370.0, -40.0),
              const Offset(0.0, 0.0),
              const Offset(370.0, -40.0)
            ],
          ),
        autoplay: list.length == 1 ? false : true,
      ),
    );
  }
}
