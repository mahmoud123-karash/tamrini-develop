import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/food/presentation/manager/article_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/article_cubit/supplement_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_grid_view_widget.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_message_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementGridViewBuilderWidget extends StatelessWidget {
  const SupplementGridViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplementCubit, SupplementStates>(
      builder: (context, state) {
        if (state is SucessGetSupplementState) {
          if (state.list.isEmpty) {
            return SupplementMessageBuilderWidget(
              message: S.of(context).no_results,
            );
          }
          return SupplementGridViewWidget(list: state.list);
        } else if (state is ErrorGetSupplementState) {
          return SupplementMessageBuilderWidget(message: state.message);
        } else {
          return Center(
            child: SizedBox(
              height: 100.h,
              child: Image.asset(Assets.imagesLoading),
            ),
          );
        }
      },
    );
  }
}
