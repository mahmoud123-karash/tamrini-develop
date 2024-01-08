import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';

import 'name_location_trainer_widget.dart';

class TrainerNameLoactionImageWidget extends StatelessWidget {
  const TrainerNameLoactionImageWidget(
      {super.key,
      required this.address,
      required this.name,
      required this.image});
  final String address, name, image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage: FirebaseImageProvider(
              FirebaseUrl(image),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          NameLocationTrainerWidget(
            name: name,
            address: address,
          )
        ],
      ),
    );
  }
}
