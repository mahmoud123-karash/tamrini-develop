import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BanIconArticleWidget extends StatelessWidget {
  const BanIconArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Icon(
        Ionicons.ban_outline,
        color: Colors.red,
      ),
    );
  }
}
