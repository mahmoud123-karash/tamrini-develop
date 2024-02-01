import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamrini/core/contants/constants.dart';

class SubscriberItemLoadingBuilderWidget extends StatelessWidget {
  const SubscriberItemLoadingBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Shimmer(
      gradient: LinearGradient(
        colors: [
          whiteColor,
          greyColor,
          appColor,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appColor.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: appColor.withOpacity(0.3),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width / 2.3,
                          height: 20,
                          color: appColor.withOpacity(0.3),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: width / 5,
                          height: 20,
                          color: appColor.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: blackColor,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
