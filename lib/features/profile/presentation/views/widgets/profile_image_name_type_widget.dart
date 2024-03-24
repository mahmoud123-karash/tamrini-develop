import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/ban_user_dailog_widget.dart';

import 'profile_name_type_widget.dart';

class ProfileImageNameTypeWidget extends StatelessWidget {
  const ProfileImageNameTypeWidget({
    super.key,
    required this.name,
    required this.image,
    required this.role,
    required this.isProfile,
    required this.uid,
  });
  final String name, image, role, uid;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          CirclarImageWidget(
            radius: 50,
            image: image,
          ),
          const SizedBox(
            width: 10,
          ),
          ProfileNameTypeWidget(
            name: name,
            role: role,
          ),
          if (!isProfile)
            if (userType == UserType.admin) const Spacer(),
          if (!isProfile)
            if (userType == UserType.admin)
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BanUserDailogWidget(
                      uid: uid,
                    ),
                  );
                },
                icon: const Icon(Icons.more_vert_outlined),
              ),
        ],
      ),
    );
  }
}
