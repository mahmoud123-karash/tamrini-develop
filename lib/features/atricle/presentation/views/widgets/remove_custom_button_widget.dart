import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveCustomButtonWidget extends StatelessWidget {
  const RemoveCustomButtonWidget({super.key, required this.model});
  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return model.writerUid != uid
        ? Container()
        : Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.bottomSlide,
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
