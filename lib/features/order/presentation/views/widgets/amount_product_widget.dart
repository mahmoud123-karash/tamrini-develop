import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/order/presentation/manager/address_cubit/address_cubit.dart';
import 'package:tamrini/features/order/presentation/views/widgets/amount_container_widget.dart';

class AmountProductWidget extends StatelessWidget {
  const AmountProductWidget({super.key, required this.amount});
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(),
      ),
      child: Row(
        children: [
          AmoutContainerWidget(
            onPressed: () {
              AddressCubit.get(context).addAmout();
            },
            icon: Icons.add,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$amount',
              style: TextStyles.style14.copyWith(
                color: appColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AmoutContainerWidget(
            onPressed: () {
              AddressCubit.get(context).removeAmout();
            },
            icon: Icons.remove,
          ),
        ],
      ),
    );
  }
}
