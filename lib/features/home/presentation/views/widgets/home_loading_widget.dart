import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamrini/core/contants/constants.dart';

import 'title_and_more_button_row_widget.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key, required this.lable});
  final String lable;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          greyColor.withOpacity(0.1),
          appColor.withOpacity(0.5),
        ],
      ),
      child: Column(
        children: [
          TitleAndMoreButtonRowWidget(
            lable: lable,
            onPressed: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: getHeight * 0.3,
            child: ScrollSnapList(
              itemCount: 5,
              itemSize: getWidht - 25,
              dynamicItemSize: true,
              dynamicSizeEquation: (double distance) {
                return 1 - min(distance.abs() / 500, 0.2);
              },
              shrinkWrap: true,
              onItemFocus: (index) {},
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: appColor,
                  width: getWidht - 70,
                  height: getHeight * 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
