import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/chat/presentation/views/chat_screen.dart';
import 'package:tamrini/features/gym/presentation/views/gym_owner_screen.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/notification/presentation/views/widgets/promotion_dialog_widget.dart';
import 'package:tamrini/features/order/presentation/views/order_details_screen.dart';
import 'package:tamrini/features/order/presentation/views/orders_screen.dart';
import 'package:tamrini/features/profile/presentation/views/profile_screen.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';
import 'package:tamrini/features/profits/presentation/views/profits_requests_screen.dart';
import 'package:tamrini/features/promotion/presentation/views/promotion_screen.dart';
import 'package:tamrini/features/questions/presentation/views/answers_screen.dart';
import 'package:tamrini/features/settings/presentation/views/contact_us_screen.dart';
import 'package:tamrini/features/store/presentation/views/store_owner_screen.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/views/trainee_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/trainer_subscribers_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/training_course_screen.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
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
                        TrainerProfileScreen(id: model.user.uid),
                      );
                    } else {
                      navigateTo(context, UserProfileScreen(model: model.user));
                    }
                  }
                }
              },
              child: CirclarImageWidget(
                image: model.user.image,
                radius: 35,
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
    String trainerId = CacheHelper.getData(key: 'trainerId') ?? '';
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    List<TraineeModel> list = TraineeCubit.get(context).trainees;
    if (model.type == 'notification') {
      String type = CacheHelper.getData(key: 'usertype') ?? '';
      if (model.subType == 'question') {
        navigateTo(
          context,
          AnswersScreen(uid: model.uid, model: getUserFromProfile()),
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
        if (type == UserType.user) {
          showDialog(
            context: context,
            builder: (context) => PromotionDialogWidget(type: model.body),
          );
        }
      }

      if (model.subType == 'ban_user') {
        navigateTo(context, const ContactUsScreen());
      }
      if (model.subType == UserType.trainer) {
        navigateTo(context, TrainerProfileScreen(id: model.uid));
      }

      if (model.subType == 'trainee' || model.subType == 'renew_trainee') {
        List<TrainerModel> list = TrainersCubit.get(context)
            .trainers
            .where((element) => element.uid == uid)
            .toList();
        TrainerModel? trainer = list.isEmpty ? null : list.first;
        if (trainer != null) {
          TraineeModel trainee =
              TraineeCubit.get(context).getTrainee(id: model.uid);
          navigateTo(
              context,
              TraineeScreen(
                  user: model.user, model: trainee, logo: trainer.logo));
        }
      }

      if (model.subType == 'course') {
        if (trainerId == model.user.uid) {
          navigateTo(context, const TrainingCourseScreen());
        }
      }

      if (model.subType == 'new_order') {
        navigateTo(context, const OrdersScreen(isUser: false));
      }

      if (model.subType == 'follow') {
        List<TrainerModel> list = TrainersCubit.get(context)
            .trainers
            .where((element) => element.uid == uid)
            .toList();
        TrainerModel? trainer = list.isEmpty ? null : list.first;
        if (trainer != null) {
          navigateTo(context, TrainerSubscribersScreen(logo: trainer.logo));
        }
      }
      if (model.subType == 'message') {
        if (trainerId == model.user.uid ||
            list.any((element) => element.user!.uid == model.user.uid)) {
          navigateTo(
            context,
            ChatScreen(
              name: model.user.name,
              image: model.user.image,
              chatId: model.uid,
              recieverUid: model.user.uid,
            ),
          );
        }
      }
      if (model.subType == 'request_profits') {
        navigateTo(context, const ProfitsRequestScreen());
      }

      if (model.subType == 'accept_profits') {
        if (model.subType == UserType.trainer) {
          navigateTo(context, TrainerProfileScreen(id: model.uid));
        } else if (model.subType == UserType.gymOwner) {
          navigateTo(context, const GymOwnerScreen());
        } else if (model.subType == UserType.storeOwner) {
          navigateTo(context, const StoreOwnerScreen());
        }
      }
    }
  }
}
