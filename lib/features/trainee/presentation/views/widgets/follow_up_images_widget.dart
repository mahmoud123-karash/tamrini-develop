import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class FollowUpImagesWidget extends StatelessWidget {
  const FollowUpImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ImageCubit, ImageStates>(
      builder: (context, state) {
        List<String> paths = ImageCubit.get(context).paths;
        return Column(
          children: [
            if (paths.isEmpty)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S.of(context).image_tariner_hint),
                ),
              ),
            if (paths.isNotEmpty)
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        width: width / 1.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(
                                paths[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ImageCubit.get(context)
                              .removeImage(path: paths[index]);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                  itemCount: paths.length,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      ImageCubit.get(context).imgsFromGallery();
                    },
                    child: Text(
                      S.of(context).add_images,
                      style: TextStyles.style16Bold.copyWith(
                        color: appColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.image,
                    color: appColor,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
