import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class ProfileGenderWidget extends StatefulWidget {
  const ProfileGenderWidget({super.key, required this.gender});
  final String gender;

  @override
  State<ProfileGenderWidget> createState() => _ProfileGenderWidgetState();
}

class _ProfileGenderWidgetState extends State<ProfileGenderWidget> {
  late String gValue;
  @override
  void initState() {
    gValue = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          secondary: const Icon(Icons.male),
          title: Text(
            S.of(context).male,
            style: TextStyles.style17,
          ),
          value: 'Male',
          groupValue: gValue,
          onChanged: (value) {
            saveGender('Male');
            setState(() {
              gValue = value!;
            });
          },
        ),
        RadioListTile(
          secondary: const Icon(Icons.female_sharp),
          title: Text(
            S.of(context).female,
            style: TextStyles.style17,
          ),
          value: 'Female',
          groupValue: gValue,
          onChanged: (value) {
            saveGender('Female');
            setState(() {
              gValue = value!;
            });
          },
        )
      ],
    );
  }
}
