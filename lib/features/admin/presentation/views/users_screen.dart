import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title),
    );
  }
}
