import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/cubit/image_cubit/image_states.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';

class EditProfileImageStackWidget extends StatelessWidget {
  const EditProfileImageStackWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          BlocBuilder<ImageCubit, ImageStates>(
            builder: (context, state) {
              List<String> paths = ImageCubit.get(context).paths;
              if (state is SucessPickImageState) {
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                    File(paths.first),
                  ),
                );
              } else {
                return CirclarImageWidget(
                  radius: 50,
                  image: image,
                );
              }
            },
          ),
          GestureDetector(
            onTap: () {
              ImageCubit.get(context).pickImage();
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: appColor,
              child: Center(
                child: Icon(
                  Ionicons.camera,
                  color: whiteColor,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
