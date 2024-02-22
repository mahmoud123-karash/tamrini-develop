import 'package:flutter/material.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';

import 'widgets/stores_list_view_builder_widget.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500)).then(
          (value) {
            StoreCubit.get(context).getData();
          },
        );
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: StoresListViewBuilderWidget(),
      ),
    );
  }
}
