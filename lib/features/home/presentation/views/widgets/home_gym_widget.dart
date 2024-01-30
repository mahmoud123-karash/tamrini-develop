import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/views/all_gyms_screen.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/home/presentation/views/widgets/gym_home_list_view_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/title_and_more_button_row_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/update_location_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeGymWidget extends StatelessWidget {
  const HomeGymWidget({super.key, required this.list});
  final List<GymModel> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleAndMoreButtonRowWidget(
          lable: S.of(context).gym,
          onPressed: () {
            navigateTo(context, const AllGymsScreen());
          },
        ),
        const SizedBox(
          height: 10,
        ),
        GymHomeListViewWidget(
          models: list,
        ),
        UpdateLocationCustomButtonWidget(
          lable: S.of(context).update,
          onPressed: () {
            CacheHelper.removeData(key: 'lat');
            GymCubit.get(context).getData(update: true);
          },
        ),
      ],
    );
  }
}
