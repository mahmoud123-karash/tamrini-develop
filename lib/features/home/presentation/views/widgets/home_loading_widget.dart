import 'package:flutter/material.dart';
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
            height: 10,
          ),
          SizedBox(
            height: getHeight * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: appColor,
                    width: getWidht - 70,
                    height: getHeight * 0.18,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 50,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
