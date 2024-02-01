import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class SubscriberMessageBuilderWidget extends StatelessWidget {
  const SubscriberMessageBuilderWidget({
    super.key,
    required this.message,
    this.isSub = false,
  });
  final String message;
  final bool isSub;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSub ? appColor : null,
          ),
        ),
      ),
    );
  }
}
