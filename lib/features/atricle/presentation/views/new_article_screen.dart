import 'package:flutter/material.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/add_article_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/article_custom_builder_widget.dart';

class NewArticleScreen extends StatefulWidget {
  const NewArticleScreen({super.key, this.model});
  final ArticleModel? model;

  @override
  State<NewArticleScreen> createState() => _NewArticleScreenState();
}

class _NewArticleScreenState extends State<NewArticleScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController articleController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ImageCubit.get(context).clearPaths();
    if (widget.model != null) {
      nameController.text = widget.model!.title ?? '';
      articleController.text = widget.model!.body ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.model != null
            ? S.of(context).edit_article
            : S.of(context).add_article,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: AddArticleContentWidget(
              nameController: nameController,
              articleController: articleController,
              autovalidateMode: autovalidateMode,
              formKey: formKey,
              image: widget.model == null
                  ? ''
                  : widget.model!.image!.isEmpty
                      ? ''
                      : widget.model!.image!.first,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ArticleCustombuilderWidget(
                lable: widget.model != null
                    ? S.of(context).edit
                    : S.of(context).add,
                onPressed: () {
                  List<String> paths = ImageCubit.get(context).paths;
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (widget.model != null) {
                    } else {
                      if (paths.isNotEmpty) {
                        ArticlesCubit.get(context).addArticle(
                          title: nameController.text,
                          body: articleController.text,
                          imagePath: paths.first,
                          context: context,
                        );
                      } else {
                        showSnackBar(context, S.of(context).image_error);
                      }
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
