import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_category_articles_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementArticlesScreen extends StatefulWidget {
  const SupplementArticlesScreen({
    super.key,
    required this.title,
    required this.id,
  });
  final String title;
  final String id;

  @override
  State<SupplementArticlesScreen> createState() =>
      _SupplementArticlesScreenState();
}

class _SupplementArticlesScreenState extends State<SupplementArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title),
      body: BlocBuilder<SupplementCubit, SupplementStates>(
        builder: (context, state) {
          SupplementModel? category =
              SupplementCubit.get(context).getSupplement(widget.id);
          return category == null
              ? Center(
                  child: Text(
                    S.of(context).category_removed,
                  ),
                )
              : SupplementArticlesContextWidget(category: category);
        },
      ),
    );
  }
}
