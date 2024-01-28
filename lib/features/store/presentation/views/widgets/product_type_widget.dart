import 'package:flutter/material.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';

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
    groupValue = widget.types.isNotEmpty ? widget.types[0].title : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.types.length,
      itemBuilder: (context, index) => RadioListTile(
        title: Text(
          widget.types[index].title,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        value: widget.types[index].title,
        groupValue: groupValue,
        onChanged: (value) {
          groupValue = value!;
          setState(() {});
        },
      ),
    );
  }
}
