import 'package:flutter/material.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/writer_row_widget.dart';

class ArticleWriterWidget extends StatelessWidget {
  const ArticleWriterWidget({
    super.key,
    required this.model,
    required this.article,
  });
  final UserModel model;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: WriterRowWidget(model: model),
    );
  }
}
