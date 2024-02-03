import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class BanArticleCustomButtonWidget extends StatelessWidget {
  const BanArticleCustomButtonWidget({super.key, required this.model});
  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');
    return userType == 'admin' && model.writerUid != uid
        ? model.isRefused!
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: banWidget(
                  lable: S.of(context).ban_food_hint,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: customButton(
                  color: Colors.red,
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
                      title: model.title,
                      desc: model.isPending == true
                          ? S.of(context).no_ban_question
                          : S.of(context).ban_question,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        ArticlesCubit.get(context).banArticle(
                          isPending: model.isPending == null
                              ? false
                              : !model.isPending!,
                          articleId: model.id ?? '',
                          writerUid: model.writerUid ?? "",
                          context: context,
                        );
                      },
                    ).show();
                  },
                  lable: model.isPending == true
                      ? S.of(context).no_ban
                      : S.of(context).ban,
                ),
              )
        : Container();
  }
}
