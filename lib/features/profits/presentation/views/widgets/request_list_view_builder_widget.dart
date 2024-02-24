import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/features/profits/presentation/manager/profits_cubit/profits_states.dart';
import 'request_list_view_widget.dart';

class RequestListViewBuilderWidget extends StatelessWidget {
  const RequestListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfitsCubit, ProfitsStates>(
      builder: (context, state) {
        if (state is SuccessGetProfitsRequestsState) {
          if (state.list.isEmpty) {
            return MessageBuilderWidget(
              message: S.of(context).no_results,
            );
          }
          return RequestListViewWidget(list: state.list);
        } else if (state is ErrorGetProfitsRequestsState) {
          return MessageBuilderWidget(message: state.message);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class MessageBuilderWidget extends StatelessWidget {
  const MessageBuilderWidget({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message),
      ),
    );
  }
}
