import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../questions/presentation/views/widgets/ban_user_dailog_widget.dart';

class NameLocationTrainerWidget extends StatelessWidget {
  const NameLocationTrainerWidget(
      {super.key,
      required this.name,
      required this.address,
      required this.uid});
  final String name, address, uid;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          width: width - (90 + 40 + 30),
          child: Row(
            children: [
              Text(
                S.of(context).coach,
                style: TextStyles.style14,
              ),
              if (userType == UserType.admin) const Spacer(),
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
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: width - (90 + 60 + 30),
          ),
          child: Text(
            name,
            style: TextStyles.style16Bold.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on_rounded,
              color: Colors.amber,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: width - (90 + 60 + 30),
              ),
              child: Text(
                address,
                style: TextStyles.style14,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
