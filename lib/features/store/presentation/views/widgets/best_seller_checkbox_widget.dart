import 'package:flutter/material.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_add_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class BestSellerCheckboxWidget extends StatefulWidget {
  const BestSellerCheckboxWidget({super.key});

  @override
  State<BestSellerCheckboxWidget> createState() =>
      _BestSellerCheckboxWidgetState();
}

class _BestSellerCheckboxWidgetState extends State<BestSellerCheckboxWidget> {
  late bool isbest;
  @override
  void initState() {
    isbest = StoreCubit.get(context).isBestSeller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: CheckboxListTile(
        title: ProductAddTextWidget(
          text: S.of(context).best_seller,
        ),
        value: isbest,
        onChanged: (value) {
          isbest = value!;
          StoreCubit.get(context).isBestSeller = value;
          setState(() {});
        },
      ),
    );
  }
}
