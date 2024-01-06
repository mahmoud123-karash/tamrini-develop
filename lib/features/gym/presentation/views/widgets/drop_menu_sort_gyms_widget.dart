import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

class DropMenuSortGymsWidget extends StatelessWidget {
  const DropMenuSortGymsWidget(
      {super.key,
      required this.items,
      required this.selectedSortBy,
      required this.onChanged});
  final List<DropdownMenuItem<String>> items;
  final String selectedSortBy;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      iconDisabledColor: Colors.grey,
      iconEnabledColor: appColor,
      value: selectedSortBy,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: appColor),
      underline: Container(
        height: 2,
        color: appColor,
      ),
      onChanged: onChanged,
      items: items,
    );
  }
}
