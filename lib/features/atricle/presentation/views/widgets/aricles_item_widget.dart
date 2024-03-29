import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/image_view_widget.dart';
import '../article_details_screen.dart';
import 'remove_custom_button_widget.dart';

class AtricleItemWidget extends StatelessWidget {
  const AtricleItemWidget(
      {super.key, required this.model, required this.width});
  final ArticleModel model;
  final double width;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidth = mediaQuery.size.width;

    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          navigateTo(context, ArticleDetailsScreen(id: model.id!));
        },
        child: Stack(
          children: [
            ImageViewWidget(
              width: width,
              image: model.image == null || model.image!.isEmpty
                  ? ''
                  : model.image!.first,
            ),
            if (width == getWidth) RemoveCustomButtonWidget(model: model),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: getHeight * 0.18,
                constraints: const BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[500],
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueGrey[900]!.withOpacity(0.0),
                      Colors.blueGrey[500]!.withOpacity(0.5),
                      Colors.blueGrey[500]!.withOpacity(0.8),
                      Colors.blueGrey[500]!.withOpacity(1.0),
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          model.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        model.body!,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
