import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/features/profits/presentation/manager/profits_cubit/profits_states.dart';

class RequestCustomButtonWidget extends StatelessWidget {
  const RequestCustomButtonWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfitsCubit, ProfitsStates>(
      listener: (context, state) {
        if (state is ErrorGetProfitsRequestsState) {
          showSnackBar(context, state.message);
        }
        if (state is SuccessGetProfitsRequestsState) {}
      },
      builder: (context, state) {
        if (state is LoadingGetProfitsRequestsState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(
            onPressed: onPressed,
            lable: S.of(context).request_profits,
          );
        }
      },
    );
  }
}
