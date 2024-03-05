import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/gym/presentation/views/new_gym_screen.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/drop_menu_sort_gyms_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class AddAndSortGymWidget extends StatelessWidget {
  const AddAndSortGymWidget(
      {super.key,
      required this.items,
      required this.selectedSortBy,
      required this.onChanged});
  final List<DropdownMenuItem<String>> items;
  final String selectedSortBy;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropMenuSortGymsWidget(
            items: items,
            selectedSortBy: selectedSortBy,
            onChanged: onChanged,
          ),
          const SizedBox(
            width: 25,
          ),
          if (userType == UserType.admin)
            Expanded(
              child: addCustomButton(
                fontSize: 15,
                onPressed: () {
                  navigateTo(context, const NewGymScreen());
                },
                lable: S.of(context).add_gym,
              ),
            )
        ],
      ),
    );
  }
}
