import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/presentation/views/widgets/order_grid_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/user_order_grid_view_builder_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key, required this.isUser});
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).orders),
      body: isUser
          ? const UserOrderGridViewBuilderWidget()
          : const OrderGridViewBuilderWidget(),
    );
  }
}
