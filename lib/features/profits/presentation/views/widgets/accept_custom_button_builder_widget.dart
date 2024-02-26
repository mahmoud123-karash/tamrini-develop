import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/features/profits/presentation/manager/profits_cubit/profits_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../manager/profits_cubit/profits_states.dart';

class AcceptCustomButtonBuilderWidget extends StatelessWidget {
  const AcceptCustomButtonBuilderWidget({super.key, required this.model});
  final ProfitsModel model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfitsCubit, ProfitsStates>(
      listener: (context, state) {
        if (state is ErrorGetProfitsRequestsState) {
          ProfitsCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        if (state is LoadingGetProfitsRequestsState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return customButton(
            color: model.status == 'wating' ? appColor : Colors.red,
            onPressed: () {
              if (model.status == 'wating') {
                ProfitsCubit.get(context).accept(model: model);
              } else {
                ProfitsCubit.get(context).removeRequest(id: model.requestuid);
              }
            },
            lable: model.status == 'wating'
                ? S.of(context).accept_reqest
                : S.of(context).remove_question,
          );
        }
      },
    );
  }
}
