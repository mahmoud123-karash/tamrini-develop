import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/pending_articles_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class PendingArticlesCustomButtonWidget extends StatelessWidget {
  const PendingArticlesCustomButtonWidget({super.key, required this.list});
  final List<ArticleModel> list;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: appColor,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      onPressed: () {
        navigateTo(context, PendingArticlesScreen(list: list));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.alarm_off_sharp,
            color: whiteColor,
            size: 18,
          ),
          const SizedBox(
            width: 5,
          ),
          AutoSizeText(
            "${S.of(context).penging_articles} : ${list.length}",
            style: TextStyles.style13.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
