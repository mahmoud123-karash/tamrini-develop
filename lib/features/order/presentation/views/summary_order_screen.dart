import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/order_details_content_widget.dart';
import 'widgets/submit_order_custonm_buttom_builder_widget.dart';

class SummaryOrderScreen extends StatelessWidget {
  const SummaryOrderScreen({
    super.key,
    required this.model,
    required this.name,
    required this.phone,
    required this.address,
    required this.storeId,
  });
  final Product model;
  final String name, phone, address, storeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).summary_deatils),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: OrderDetailsContentWidget(
              model: model,
              name: name,
              phone: phone,
              address: address,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SubmitOrederCustomButtonBuilderWidget(
                product: model,
                name: name,
                address: address,
                phone: phone,
                storeId: storeId,
              ),
            ),
          )
        ],
      ),
    );
  }
}
