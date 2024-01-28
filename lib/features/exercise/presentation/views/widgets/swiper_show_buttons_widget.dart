import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/features/exercise/presentation/manager/swiper_cubit/swiper_cubit.dart';

class SwiperShowButtonsWidget extends StatelessWidget {
  const SwiperShowButtonsWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            SwiperCubit.get(context).showImage();
          },
          icon: Icon(
            Icons.image,
            color: index == 0 ? Colors.amber : null,
          ),
        ),
        IconButton(
          onPressed: () {
            SwiperCubit.get(context).showVedio();
          },
          icon: Icon(
            Ionicons.videocam,
            color: index == 1 ? Colors.amber : null,
          ),
        )
      ],
    );
  }
}
