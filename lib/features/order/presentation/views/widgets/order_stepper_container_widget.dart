import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class OrderStepperDetailsWidget extends StatefulWidget {
  const OrderStepperDetailsWidget({super.key, required this.step});
  final int step;

  @override
  State<OrderStepperDetailsWidget> createState() =>
      _OrderStepperDetailsWidgetState();
}

class _OrderStepperDetailsWidgetState extends State<OrderStepperDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: appColor,
        ),
      ),
      child: Stepper(
        currentStep: 1,
        steps: [
          Step(
            state: widget.step > 0 ? StepState.complete : StepState.indexed,
            isActive: widget.step >= 0,
            title: const Text('Pending'),
            content: const Text('Your order is yet to be delivered'),
          ),
          Step(
            state: widget.step > 1 ? StepState.complete : StepState.indexed,
            isActive: widget.step >= 1,
            title: const Text('Compeleted'),
            content: const Text(
                'Your order has been delivered, you are yet to sign.'),
          ),
          Step(
            state: widget.step > 2 ? StepState.complete : StepState.indexed,
            isActive: widget.step >= 2,
            title: const Text('Received'),
            content:
                const Text('Your order has been delivered and signed by you'),
          ),
          Step(
            state: widget.step == 3 ? StepState.complete : StepState.indexed,
            isActive: widget.step == 3,
            title: const Text('Delivered'),
            content:
                const Text('Your order has been delivered and signed by you!'),
          ),
        ],
      ),
    );
  }
}
