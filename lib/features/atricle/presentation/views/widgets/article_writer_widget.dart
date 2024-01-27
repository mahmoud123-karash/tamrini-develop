import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/accept_refuse_row_buttons_widget.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/writer_row_widget.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';
import 'package:tamrini/generated/l10n.dart';

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
      child: GestureDetector(
        onTap: () {
          String uid = CacheHelper.getData(key: 'uid') ?? '';
          if (model.role == 'admin') {
            showSnackBar(context, S.of(context).admin_hint);
          }
          if (model.uid == uid) {
            navigateTo(context, const ProfileScreen());
          }
          if (model.role == 'writer') {
            navigateTo(context, UserProfileScreen(model: model));
          }
        },
        child: Column(
          children: [
            WriterRowWidget(model: model),
            const Divider(),
            if (!article.isRefused!)
              AcceptRefuseButtonsWidget(
                article: article,
                token: model.token,
              ),
          ],
        ),
      ),
    );
  }
}
