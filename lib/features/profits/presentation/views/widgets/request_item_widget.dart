import 'package:intl/intl.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/core/widgets/writer_row_widget.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';

import 'accept_custom_button_builder_widget.dart';
import 'request_info_row_widget.dart';

class RequestItemWidget extends StatelessWidget {
  const RequestItemWidget({super.key, required this.model});
  final ProfitsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: model.status == 'wating'
            ? appColor.withOpacity(0.3)
            : greyColor.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              S.of(context).request_profits_title,
              style: TextStyles.style14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            WriterRowWidget(model: model.user!),
            const SizedBox(
              height: 8,
            ),
            RequestInfoRowWidget(
              value: '${model.amount} ${S.of(context).dinar}',
              lable: S.of(context).quantity,
            ),
            Divider(
              color: blackColor,
            ),
            RequestInfoRowWidget(
              value: model.cashNumber,
              lable: S.of(context).cash_num,
            ),
            Divider(
              color: blackColor,
            ),
            RequestInfoRowWidget(
              value: DateFormat('M/d/y').format(
                model.requestedAt.toDate(),
              ),
              lable: S.of(context).date,
            ),
            Divider(
              color: blackColor,
            ),
            RequestInfoRowWidget(
              value: model.status == 'wating'
                  ? S.of(context).waiting_status
                  : S.of(context).ended_status,
              lable: S.of(context).status,
            ),
            const SizedBox(
              height: 15,
            ),
            if (model.status == 'wating')
              AcceptCustomButtonBuilderWidget(model: model),
          ],
        ),
      ),
    );
  }
}
