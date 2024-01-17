import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamrini/core/contants/constants.dart';

class CLassificationLoadingWidget extends StatelessWidget {
  const CLassificationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [appColor, greyColor],
      ),
      child: ListView.separated(
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: appColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: 15,
      ),
    );
  }
}
