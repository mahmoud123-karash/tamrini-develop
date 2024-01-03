import 'package:flutter/material.dart';
import 'package:tamrini/features/home/presentation/views/widgets/text_value_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ArticleWriterAndDate extends StatelessWidget {
  const ArticleWriterAndDate(
      {super.key, required this.writer, required this.date});
  final String writer, date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextValueRowWidget(
          text: S.of(context).by,
          value: writer,
        ),
        const SizedBox(
          height: 10,
        ),
        TextValueRowWidget(
          text: S.of(context).date,
          value: date,
        ),
      ],
    );
  }
}
