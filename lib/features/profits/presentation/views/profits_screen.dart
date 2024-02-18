import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/profits_content_widget.dart';

class ProfitsScreen extends StatefulWidget {
  const ProfitsScreen({super.key, required this.profits});
  final num profits;

  @override
  State<ProfitsScreen> createState() => _ProfitsScreenState();
}

class _ProfitsScreenState extends State<ProfitsScreen> {
  TextEditingController controller = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).profits),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfitsContentWidget(
              controller: controller,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              profits: widget.profits,
            ),
          ),
          SliverFillRemaining(
            child: widget.profits < 5000
                ? Container()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: customButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (int.parse(controller.text) < 5000) {
                              showSnackBar(
                                  context, S.of(context).request_profits_hint);
                            }
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                        lable: S.of(context).request_profits,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
