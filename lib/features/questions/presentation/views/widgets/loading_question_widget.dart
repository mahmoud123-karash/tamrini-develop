import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/loading_item_widget.dart';

class LoadingQuestionWidget extends StatelessWidget {
  const LoadingQuestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [appColor.withOpacity(0.5), greyColor],
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => const LoadingItemWidget(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: 5,
      ),
    );
  }
}
