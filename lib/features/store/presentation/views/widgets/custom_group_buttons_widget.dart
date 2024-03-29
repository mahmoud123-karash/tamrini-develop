import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/store/presentation/views/widgets/animated_container_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class CustomGroupButtonWidget extends StatelessWidget {
  const CustomGroupButtonWidget({
    super.key,
    required this.onPressedP,
    required this.onPressedB,
    required this.isTapped,
  });
  final VoidCallback onPressedP, onPressedB;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainerWidget(
            color: isTapped ? appColor : whiteColor,
            lable: S.of(context).category,
            onPressed: onPressedP,
            textColor: isTapped ? whiteColor : blackColor,
          ),
          const SizedBox(
            width: 15,
          ),
          AnimatedContainerWidget(
            color: !isTapped ? appColor : whiteColor,
            lable: S.of(context).allProducts,
            onPressed: onPressedB,
            textColor: !isTapped ? whiteColor : blackColor,
          )
        ],
      ),
    );
  }
}
