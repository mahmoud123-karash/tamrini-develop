import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_states.dart';
import 'package:tamrini/features/atricle/presentation/views/new_article_screen.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/article_writer_builder_widget.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/generated/l10n.dart';
import '../../../home/presentation/views/widgets/image_view_widget.dart';
import 'widgets/refused_article_text_widget.dart';

class ArticlesDetailsScreen extends StatelessWidget {
  const ArticlesDetailsScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    String userType = CacheHelper.getData(key: 'usertype');
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(),
        title: Text(
          S.of(context).arDetails,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesStates>(
        builder: (context, state) {
          ArticleModel model = ArticlesCubit.get(context).getArticle(id);
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (model.isRefused!) const RefusedArticleTextWidget(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          model.title ?? '',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: Intl.getCurrentLocale() == 'en'
                              ? TextAlign.end
                              : TextAlign.start,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (model.image != null || model.image!.isNotEmpty)
                        ImageViewWidget(
                          image: model.image!.first,
                          width: getWidht,
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            """${(model.body)}""",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      ArticlWriterBuilderWidget(
                        uid: model.writerUid ?? '',
                        article: model,
                      ),
                      if (model.writerUid == uid)
                        if (userType == 'admin' || userType == 'writer')
                          const Divider(),
                      if (model.writerUid == uid)
                        if (userType == 'admin' || userType == 'writer')
                          customButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                NewArticleScreen(model: model),
                              );
                            },
                            lable: S.of(context).edit,
                          )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
