import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

class ContainerValuesWidget extends StatelessWidget {
  const ContainerValuesWidget(
      {super.key, required this.value, required this.lable});
  final String value, lable;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        child: Container(
          height: 85,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: greyColor,
                offset: const Offset(2, 2),
                blurRadius: 8,
                spreadRadius: 2,
                blurStyle: BlurStyle.inner,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyles.style14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  lable,
                  style: TextStyles.style14.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: lable.length > 8 ? 10 : 13,
                  ),
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
