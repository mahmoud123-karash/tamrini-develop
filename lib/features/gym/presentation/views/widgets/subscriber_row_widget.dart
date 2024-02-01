import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/subscriber_name_type_widget.dart';
import 'package:tamrini/features/profile/presentation/views/user_profile_screen.dart';

class SudscriberRowWidget extends StatelessWidget {
  const SudscriberRowWidget({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            navigateTo(context, UserProfileScreen(model: user));
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: user.image != ''
                ? FirebaseImageProvider(
                    FirebaseUrl(user.image),
                  )
                : const AssetImage(Assets.imagesProfile) as ImageProvider,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SubscriberNameTypeWidget(
          name: user.name,
          type: user.role,
        ),
      ],
    );
  }
}
