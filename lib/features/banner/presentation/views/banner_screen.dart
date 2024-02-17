import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import 'new_banner_screen.dart';
import 'widgets/banner_list_view_builder_widget.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).banners,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          children: [
            customButton(
              onPressed: () {
                navigateTo(
                  context,
                  const NewBannerScreen(),
                );
              },
              lable: S.of(context).add_new_banner,
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: BannerListViewBuilderWidget(),
            )
          ],
        ),
      ),
    );
  }
}
