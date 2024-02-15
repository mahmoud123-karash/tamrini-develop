import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';

import 'widgets/users_content _builder_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key, required this.title, required this.usrType});
  final String title;
  final String usrType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title),
      body: UsersContentBuilderWidget(
        userType: usrType,
      
      ),
    );
  }
}
