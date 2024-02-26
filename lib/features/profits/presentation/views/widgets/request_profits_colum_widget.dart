import 'package:tamrini/core/utils/improts.dart';
import 'request_profits_info_row_widget.dart';

class RequestProfitsColumWidget extends StatelessWidget {
  const RequestProfitsColumWidget({
    super.key,
    required this.cashNum,
    required this.date,
    required this.status,
  });
  final String cashNum, date, status;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequestProfitsInfoRowWidget(
          lable: S.of(context).cash_num,
          value: cashNum,
        ),
        const SizedBox(
          height: 5,
        ),
        RequestProfitsInfoRowWidget(
          lable: S.of(context).date,
          value: date,
        ),
        const SizedBox(
          height: 5,
        ),
        RequestProfitsInfoRowWidget(
          lable: S.of(context).status,
          value: status == 'wating'
              ? S.of(context).waiting_status
              : S.of(context).ended_status,
        ),
      ],
    );
  }
}
