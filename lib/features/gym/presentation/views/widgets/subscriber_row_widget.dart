import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriber_name_type_widget.dart';

class SudscriberRowWidget extends StatelessWidget {
  const SudscriberRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(Assets.imagesProfile),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const SubscriberNameTypeWidget(),
      ],
    );
  }
}
