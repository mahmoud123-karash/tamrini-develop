import 'package:flutter/material.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/favorite_list_view_builder_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).favorite_meals),
      body: const FavoriteListViewBuilderWidget(),
    );
  }
}
