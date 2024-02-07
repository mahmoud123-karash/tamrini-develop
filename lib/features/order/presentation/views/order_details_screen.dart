import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/order_details_strem_content_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).summary_deatils),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data == null) {
              return Center(
                child: Text(
                S.of(context).error,
                ),
              );
            } else {
              Map<String, dynamic> map =
                  snapshot.data!.data() as Map<String, dynamic>;
              OrderModel order = OrderModel.fromJson(map);
              return OrderDetailsStreamContentWidget(order: order);
            }
          }
        },
      ),
    );
  }
}
