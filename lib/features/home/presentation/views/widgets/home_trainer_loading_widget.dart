import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/home/presentation/views/widgets/loading_trainer_home_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/title_and_more_button_row_widget.dart';

import 'package:tamrini/generated/l10n.dart';

class LoadingTrainerHomeWidget extends StatelessWidget {
  const LoadingTrainerHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(colors: [appColor.withOpacity(0.4), greyColor]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleAndMoreButtonRowWidget(
            lable: S.of(context).top_trainers,
            onPressed: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 85,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    const HomeTrainerLoadingWidget(),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 30,
                ),
                itemCount: 5,
              ),
            ),
          ),
          const Divider(
            height: 50,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
