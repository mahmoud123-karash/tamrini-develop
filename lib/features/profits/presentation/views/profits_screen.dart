import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/profits_cubit/profits_cubit.dart';
import '../manager/profits_cubit/profits_states.dart';
import 'widgets/profits_content_widget.dart';

class ProfitsScreen extends StatefulWidget {
  const ProfitsScreen({
    super.key,
    required this.profits,
    required this.id,
  });
  final num profits;
  final String id;

  @override
  State<ProfitsScreen> createState() => _ProfitsScreenState();
}

class _ProfitsScreenState extends State<ProfitsScreen> {
  @override
  void initState() {
    ProfitsCubit.get(context).getmyRequests(uid: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).profits),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(milliseconds: 1000)).then(
            (value) {
              ProfitsCubit.get(context)
                  .getmyRequests(isUpdate: true, uid: widget.id);
            },
          );
        },
        child: BlocBuilder<ProfitsCubit, ProfitsStates>(
          builder: (context, state) {
            if (state is SuccessGetProfitsRequestsState) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: ProfitsContentWidget(
                      totalProfits: widget.profits,
                      id: widget.id,
                      list: state.list,
                    ),
                  ),
                ],
              );
            } else if (state is ErrorGetProfitsRequestsState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
