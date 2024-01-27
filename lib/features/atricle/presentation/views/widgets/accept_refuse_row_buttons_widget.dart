import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/artilcle_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../manager/article_cubit/articles_states.dart';

class AcceptRefuseButtonsWidget extends StatefulWidget {
  const AcceptRefuseButtonsWidget(
      {super.key, required this.article, required this.token});
  final ArticleModel article;
  final String token;

  @override
  State<AcceptRefuseButtonsWidget> createState() =>
      _AcceptRefuseButtonsWidgetState();
}

class _AcceptRefuseButtonsWidgetState extends State<AcceptRefuseButtonsWidget> {
  late bool isRef;
  @override
  void initState() {
    isRef = widget.article.isRefused ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isRef
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text(
                S.of(context).refused_article,
                style: TextStyles.style14.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          )
        : Row(
            children: [
              Expanded(
                child: BlocListener<ArticlesCubit, ArticlesStates>(
                  listener: (context, state) {
                    if (state is SucessGetArticlesState) {
                      Navigator.pop(context);
                    }
                  },
                  child: ArticleCustomButtonWidget(
                    color: appColor,
                    lable: S.of(context).accept,
                    onPressed: () {
                      isRef = false;
                      setState(() {});
                      ArticlesCubit.get(context).updateArticle(
                        oldModel: widget.article,
                        isAcceped: true,
                        token: widget.token,
                        context: context,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ArticleCustomButtonWidget(
                  color: Colors.red,
                  lable: S.of(context).refuse,
                  onPressed: () {
                    isRef = true;
                    setState(() {});
                    ArticlesCubit.get(context).updateArticle(
                      oldModel: widget.article,
                      isAcceped: false,
                      token: widget.token,
                      context: context,
                    );
                  },
                ),
              ),
            ],
          );
  }
}
