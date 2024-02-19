import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/profits/data/repo/profits_repo_impl.dart';
import 'package:tamrini/features/profits/presentation/manager/request_cubit/request_cubit.dart';
import 'package:tamrini/features/profits/presentation/manager/request_cubit/request_states.dart';
import 'package:tamrini/features/profits/presentation/views/widgets/request_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/profits_content_widget.dart';

class ProfitsScreen extends StatefulWidget {
  const ProfitsScreen({
    super.key,
    required this.profits,
    required this.isRequestProfits,
    required this.id,
  });
  final num profits;
  final bool isRequestProfits;
  final String id;

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
    return BlocProvider(
      create: (context) => RequestCubit(
        getIt.get<ProfitsRepoImpl>(),
      ),
      child: Scaffold(
        appBar: myAppBar(S.of(context).profits),
        body: BlocBuilder<RequestCubit, RequestStates>(
          builder: (context, state) {
            RequestCubit.get(context).isRequest = widget.isRequestProfits;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ProfitsContentWidget(
                    controller: controller,
                    autovalidateMode: autovalidateMode,
                    formKey: formKey,
                    profits: widget.profits,
                    isRequest: RequestCubit.get(context).isRequest,
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
                            child: RequestCustomButtonWidget(
                              onPressed: () {
                                int amout = int.parse(controller.text);
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  if (amout < 5000) {
                                    showSnackBar(context,
                                        S.of(context).request_profits_hint);
                                  } else {
                                    RequestCubit.get(context).request(
                                      amount: amout,
                                      id: widget.id,
                                    );
                                  }
                                } else {
                                  autovalidateMode = AutovalidateMode.always;
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
