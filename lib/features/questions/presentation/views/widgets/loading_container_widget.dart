import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class LoadingContainerWidget extends StatelessWidget {
  const LoadingContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: appColor.withOpacity(0.5),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
