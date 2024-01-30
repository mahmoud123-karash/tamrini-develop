import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/image_item_widget.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/text_images_new_gym_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class OldImagesListViewWidget extends StatelessWidget {
  const OldImagesListViewWidget({
    super.key,
    required this.height,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) {
        List<String> imgs = ImageCubit.get(context).images;
        return imgs.isEmpty
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextImagesNewGymWidget(
                    lable: S.of(context).old_images,
                  ),
                  SizedBox(
                    height: height / 4,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ImageItemWidget(
                        imageProvider: FirebaseImageProvider(
                          FirebaseUrl(imgs[index]),
                        ),
                        onClose: () {
                          ImageCubit.get(context).removeOldImage(index);
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
      },
    );
  }
}
