import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/improts.dart';

import 'request_custom_button_widget.dart';

class RequestProfitsContainerWidget extends StatefulWidget {
  const RequestProfitsContainerWidget(
      {super.key, required this.id, required this.availableProfits});
  final String id;
  final num availableProfits;

  @override
  State<RequestProfitsContainerWidget> createState() =>
      _RequestProfitsContainerWidgetState();
}

class _RequestProfitsContainerWidgetState
    extends State<RequestProfitsContainerWidget> {
  TextEditingController controller = TextEditingController();
  TextEditingController cashController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    cashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greyColor.withOpacity(0.2),
      ),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).enter_profits_value,
                style: TextStyles.style13.copyWith(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              addTextField(
                keyboardType: TextInputType.number,
                lable: S.of(context).profits,
                controller: controller,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).enter_your_cash_number,
                style: TextStyles.style13.copyWith(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              addTextField(
                keyboardType: TextInputType.number,
                lable: S.of(context).cash_number,
                controller: cashController,
                context: context,
                autovalidateMode: autovalidateMode,
              ),
              const SizedBox(
                height: 10,
              ),
              RequestCustomButtonWidget(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    int amout = int.parse(controller.text);
                    formKey.currentState!.save();
                    if (amout < 100000) {
                      showSnackBar(context, S.of(context).request_profits_hint);
                    } else {
                      if (widget.availableProfits < amout) {
                        showSnackBar(context, S.of(context).no_enough_profits);
                      } else {
                        ProfitsCubit.get(context).request(
                          amount: amout,
                          cashNumber: cashController.text,
                          id: widget.id,
                        );
                      }
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
