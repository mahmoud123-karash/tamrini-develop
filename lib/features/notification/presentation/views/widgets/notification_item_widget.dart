import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/gym_owner_screen.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/notification/presentation/views/widgets/promotion_dialog_widget.dart';
import 'package:tamrini/features/order/presentation/views/order_details_screen.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/features/promotion/presentation/views/promotion_screen.dart';
import 'package:tamrini/features/questions/presentation/views/answers_screen.dart';
import 'package:tamrini/features/store/presentation/views/store_owner_screen.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';
import 'package:tamrini/generated/l10n.dart';
import 'notification_body_widget.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({super.key, required this.model});
  final NotificationModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!model.isReaden) {
          NotificationCubit.get(context).updateNotification(
            model: model,
          );
        }

        notificationNavigate(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
            GestureDetector(
              onTap: () {
                String uid = CacheHelper.getData(key: 'uid') ?? '';
                if (model.user.uid == uid) {
                  navigateTo(context, const ProfileScreen());
                } else {
                  if (model.user.role == 'admin') {
                    showSnackBar(context, S.of(context).admin_hint);
                  } else {
                    if (model.user.role == 'trainer') {
                      navigateTo(
                        context,
                        TrainerProfileScreen(
                          trainer: TrainersCubit.get(context)
                              .getTrainer(uid: model.user.uid),
                        ),
                      );
                    } else {
                      navigateTo(context, UserProfileScreen(model: model.user));
                    }
                  }
                }
              },
              child: CircleAvatar(
                radius: 35,
                backgroundImage: model.user.image == ""
                    ? const AssetImage(Assets.imagesProfile) as ImageProvider
                    : FirebaseImageProvider(
                        FirebaseUrl(model.user.image),
                      ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            NotificationBodyWidget(
              body: model.body,
              title: model.title,
              date: model.time.toDate(),
              userName: model.user.name,
            ),
          ],
        ),
      ),
    );
  }

  void notificationNavigate(BuildContext context) {
    if (model.type == 'notification') {
      var box = Hive.box<ProfileModel>(profileBox);
      ProfileModel profile = box.values.toList().first;
      String type = CacheHelper.getData(key: 'usertype') ?? '';
      String token = CacheHelper.getData(key: 'deviceToken') ?? '';
      String uid = CacheHelper.getData(key: 'uid') ?? '';
      if (model.subType == 'question') {
        navigateTo(
          context,
          AnswersScreen(
            uid: model.uid,
            model: UserModel(
              role: type,
              whatsApp: profile.whatsApp ?? '',
              name: profile.name,
              image: profile.image,
              token: token,
              facebookUri: profile.facebookUri,
              uid: uid,
              instgramUri: profile.instgramUri,
              isBanned: profile.isBanned,
              address: profile.address,
              twiterUri: profile.twiterUri,
              phone: profile.phone,
            ),
          ),
        );
      }
      if (model.subType == 'store') {
        navigateTo(context, const StoreOwnerScreen());
      }

      if (model.subType == 'gym') {
        navigateTo(context, const GymOwnerScreen());
      }
      if (model.subType == 'order') {
        navigateTo(context, OrderDetailsScreen(orderId: model.uid));
      }

      if (model.subType == 'promotion') {
        navigateTo(context, const PromotionScreen());
      }

      if (model.subType == 'promotion_accept') {
        if (type == 'trainer') {
          showDialog(
            context: context,
            builder: (context) => PromotionDialogWidget(type: model.body),
          );
        }
      }
    }
  }
}
