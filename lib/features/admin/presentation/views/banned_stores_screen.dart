import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../store/presentation/views/widgets/store_item_widget.dart';

class BannedStoreScreen extends StatelessWidget {
  const BannedStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).store_banned),
      body: BlocBuilder<StoreCubit, StoreStates>(
        builder: (context, state) {
          List<StoreModel> list = StoreCubit.get(context)
              .stores
              .where((element) => element.isBanned == true)
              .toList();

          return list.isEmpty
              ? Center(
                  child: Text(S.of(context).no_results),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return StoreItemWidget(
                        model: list[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: list.length,
                  ),
                );
        },
      ),
    );
  }
}
