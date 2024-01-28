import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class IconRemoveArticleWidget extends StatelessWidget {
  const IconRemoveArticleWidget({super.key, required this.model});
  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          AwesomeDialog(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            showCloseIcon: true,
            titleTextStyle: TextStyles.style17.copyWith(
              fontWeight: FontWeight.bold,
              color: appColor,
            ),
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            title: model.title ?? '',
            desc: S.of(context).q_remove_article,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              ArticlesCubit.get(context).removeArticle(
                oldModel: model,
                context: context,
              );
            },
          ).show();
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
