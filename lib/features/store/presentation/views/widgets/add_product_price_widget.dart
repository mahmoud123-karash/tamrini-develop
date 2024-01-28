import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_add_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class AddProductPriceWidget extends StatefulWidget {
  const AddProductPriceWidget({
    super.key,
    required this.priceController,
    required this.oldPriceController,
    required this.autovalidateMode,
  });
  final TextEditingController priceController;
  final TextEditingController oldPriceController;
  final AutovalidateMode autovalidateMode;

  @override
  State<AddProductPriceWidget> createState() => _AddProductPriceWidgetState();
}

class _AddProductPriceWidgetState extends State<AddProductPriceWidget> {
  bool sale = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: CheckboxListTile(
            title: ProductAddTextWidget(
              text: S.of(context).sale,
            ),
            value: sale,
            onChanged: (value) {
              sale = value!;
              setState(() {});
            },
          ),
        ),
        addTextField(
          lable: S.of(context).product_price,
          controller: widget.priceController,
          context: context,
          autovalidateMode: widget.autovalidateMode,
          keyboardType: TextInputType.number,
        ),
        if (sale)
          const SizedBox(
            height: 20,
          ),
        if (sale)
          addTextField(
            lable: S.of(context).product_old_price,
            controller: widget.oldPriceController,
            context: context,
            autovalidateMode: widget.autovalidateMode,
            keyboardType: TextInputType.number,
          ),
      ],
    );
  }
}
