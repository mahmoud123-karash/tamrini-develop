import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';
import '../../../../questions/data/models/user_model/user_model.dart';
import 'notification_body_widget.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget(
      {super.key, required this.model, required this.user});
  final NotificationModel model;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Row(
          children: [
            if (!model.isReaden)
              Icon(
                Icons.circle,
                color: appColor,
                size: 15,
              ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 35,
              backgroundImage: user.image == ""
                  ? const AssetImage(Assets.imagesProfile) as ImageProvider
                  : FirebaseImageProvider(
                      FirebaseUrl(user.image),
                    ),
            ),
            const SizedBox(
              width: 15,
            ),
            NotificationBodyWidget(
              body: model.body,
              title: model.title,
              date: model.time.toDate(),
              userName: user.name,
            ),
          ],
        ),
      ),
    );
  }
}
