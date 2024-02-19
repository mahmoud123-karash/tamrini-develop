import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/profits/presentation/views/widgets/profits_container_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'after_request_hint_widget.dart';

class ProfitsContentWidget extends StatelessWidget {
  const ProfitsContentWidget({
    super.key,
    required this.controller,
    required this.autovalidateMode,
    required this.formKey,
    required this.profits,
    required this.isRequest,
  });
  final TextEditingController controller;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;
  final num profits;
  final bool isRequest;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfitsContainerWidget(profits: profits),
            const SizedBox(
              height: 15,
            ),
            if (isRequest) const AfterRequestHintWidget(),
            if (!isRequest)
              if (profits < 5000)
                Text(
                  S.of(context).warning_the_user_profits,
                  style: TextStyles.style14.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                  textAlign: TextAlign.center,
                ),
            if (!isRequest)
              if (profits > 5000)
                addTextField(
                  keyboardType: TextInputType.number,
                  lable: S.of(context).profits,
                  controller: controller,
                  context: context,
                  autovalidateMode: autovalidateMode,
                ),
          ],
        ),
      ),
    );
  }
}
