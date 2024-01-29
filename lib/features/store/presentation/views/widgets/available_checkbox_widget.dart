import 'package:flutter/material.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_add_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class AvailableCheckboxWidget extends StatefulWidget {
  const AvailableCheckboxWidget({super.key});

  @override
  State<AvailableCheckboxWidget> createState() =>
      _AvailableCheckboxWidgetState();
}

class _AvailableCheckboxWidgetState extends State<AvailableCheckboxWidget> {
  late bool available;
  @override
  void initState() {
    available = StoreCubit.get(context).available;
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
          text: S.of(context).available,
        ),
        value: available,
        onChanged: (value) {
          available = value!;
          StoreCubit.get(context).available = value;
          setState(() {});
        },
      ),
    );
  }
}
