import 'package:flutter/material.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/gym_item_widget.dart';
import 'package:tamrini/features/profile/presentation/views/widgets/name_text_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class GymOwnerProfileWidget extends StatelessWidget {
  const GymOwnerProfileWidget({super.key, required this.list});
  final List<GymModel> list;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return list.isEmpty
        ? Container()
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NameTextWidget(text: S.of(context).gym_owner),
              ),
              const SizedBox(
                height: 10,
              ),
              GymItemWidget(model: list.first, width: width),
              const SizedBox(
                height: 20,
              ),
            ],
          );
  }
}
