import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profits/data/repo/profits_repo_impl.dart';
import 'package:tamrini/features/profits/presentation/manager/profits_cubit/profits_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class AdminProfitsScreen extends StatelessWidget {
  const AdminProfitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfitsCubit(
        getIt.get<ProfitsRepoImpl>(),
      )..getData(),
      child: Scaffold(
        appBar: myAppBar(S.of(context).profits_request),
      ),
    );
  }
}
