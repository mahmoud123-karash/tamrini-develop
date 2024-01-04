import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/presentation/views/widgets/publisher_name_and_role_widget.dart';

import '../../../../profile/presentation/views/profile_screen.dart';

class ArticleWriterAndDate extends StatelessWidget {
  const ArticleWriterAndDate({
    super.key,
    required this.writer,
    required this.date,
    required this.writerUid,
  });
  final String writer, date, writerUid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, const ProfileScreen());
        },
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(Assets.imagesProfile),
            ),
            const SizedBox(
              width: 10,
            ),
            PublisherNameAndRoleWidget(
              role: writerUid == '' ? 'Admin' : writer,
              name: writerUid == '' ? 'Ahmed' : writer,
            ),
            const Spacer(),
            if (writerUid == '')
              const Icon(
                Icons.stars_rounded,
                color: Colors.amber,
              )
          ],
        ),
      ),
    );
  }
}
