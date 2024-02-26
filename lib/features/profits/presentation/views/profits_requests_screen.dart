import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profits/presentation/manager/profits_cubit/profits_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/request_list_view_builder_widget.dart';

class ProfitsRequestScreen extends StatelessWidget {
  const ProfitsRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).profits_request),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(milliseconds: 1000)).then(
            (value) {
              ProfitsCubit.get(context).getData();
            },
          );
        },
        child: const RequestListViewBuilderWidget(),
      ),
    );
  }
}
