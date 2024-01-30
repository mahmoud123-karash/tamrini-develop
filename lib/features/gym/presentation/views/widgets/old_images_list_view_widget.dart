import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/image_item_widget.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/text_images_new_gym_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class OldImagesListViewWidget extends StatefulWidget {
  const OldImagesListViewWidget({
    super.key,
    required this.height,
    required this.images,
  });
  final double height;
  final List<String> images;

  @override
  State<OldImagesListViewWidget> createState() =>
      _OldImagesListViewWidgetState();
}

class _OldImagesListViewWidgetState extends State<OldImagesListViewWidget> {
  late List<String> imgs;
  @override
  void initState() {
    imgs = widget.images;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return imgs.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextImagesNewGymWidget(
                lable: S.of(context).old_images,
              ),
              SizedBox(
                height: widget.height / 4,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ImageItemWidget(
                    imageProvider: FirebaseImageProvider(
                      FirebaseUrl(imgs[index]),
                    ),
                    onClose: () {
                      imgs.removeAt(index);
                      setState(() {});
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  itemCount: imgs.length,
                ),
              ),
            ],
          );
  }
}
