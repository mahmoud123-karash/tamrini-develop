import 'package:flutter/material.dart';
import 'package:tamrini/features/order/presentation/views/widgets/input_address_field_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class PincodeHoudeNumRowWidget extends StatelessWidget {
  const PincodeHoudeNumRowWidget({
    super.key,
    required this.houseNumController,
    required this.pinciodeController,
    required this.autovalidateMode,
  });
  final TextEditingController houseNumController, pinciodeController;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputAddressFieldWidget(
            controller: houseNumController,
            textInputType: TextInputType.number,
            lable: S.of(context).house_noum,
            autovalidateMode: autovalidateMode,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: InputAddressFieldWidget(
            controller: pinciodeController,
            textInputType: TextInputType.number,
            lable: S.of(context).pincode,
            autovalidateMode: autovalidateMode,
          ),
        )
      ],
    );
  }
}
