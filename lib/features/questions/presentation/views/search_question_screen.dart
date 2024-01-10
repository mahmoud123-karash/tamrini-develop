import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class SearchQuestionScreen extends StatelessWidget {
  const SearchQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).search),
        centerTitle: true,
      ),
    );
  }
}
