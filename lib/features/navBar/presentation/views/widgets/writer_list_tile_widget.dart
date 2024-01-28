import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/views/writer_articles_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'drawer_list_tile_widget.dart';

class WriterListTileWidget extends StatelessWidget {
  const WriterListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerListTileWidget(
      onPressed: () {
        navigateTo(context, const WriterArticlesScreen());
      },
      icon: Ionicons.reader_outline,
      lable: S.of(context).your_artilces,
    );
  }
}
