import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class ProductTypeWidget extends StatefulWidget {
  const ProductTypeWidget({super.key, required this.types});
  final List<CategoryModel> types;

  @override
  State<ProductTypeWidget> createState() => _ProductTypeWidgetState();
}

class _ProductTypeWidgetState extends State<ProductTypeWidget> {
  late String groupValue;

  @override
  void initState() {
    groupValue = StoreCubit.get(context).productType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.types.length + 1,
      itemBuilder: (context, index) => RadioListTile(
        title: Text(
          index == widget.types.length
              ? S.of(context).other
              : widget.types[index].title,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        value: index == widget.types.length
            ? S.of(context).other
            : widget.types[index].title,
        groupValue: groupValue,
        onChanged: (value) {
          groupValue = value ?? "";
          StoreCubit.get(context).productType = value ?? '';
          log(StoreCubit.get(context).productType);
          setState(() {});
        },
      ),
    );
  }
}
