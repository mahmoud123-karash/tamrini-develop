import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_states.dart';
import 'package:tamrini/generated/l10n.dart';

class ThemeCourseDialogWidget extends StatefulWidget {
  const ThemeCourseDialogWidget({super.key});

  @override
  State<ThemeCourseDialogWidget> createState() =>
      _ThemeCourseDialogWidgetState();
}

class _ThemeCourseDialogWidgetState extends State<ThemeCourseDialogWidget> {
  late int themeNum;
  @override
  void initState() {
    themeNum = CacheHelper.getData(key: 'courseTheme') ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeStates>(
      builder: (context, state) {
        var cubit = ThemeCubit.get(context);
        return AlertDialog(
          title: Text(
            S.of(context).choose_your_theme,
            style: TextStyles.style16Bold.copyWith(
              color: cubit.themeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => RadioListTile(
                    activeColor: cubit.themeColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    title: Container(
                      decoration: BoxDecoration(
                        color: cubit.list[index],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 25,
                    ),
                    value: index,
                    groupValue: themeNum,
                    onChanged: (value) {
                      themeNum = index;
                      setState(() {});
                    },
                  ),
                  itemCount: cubit.list.length,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: customButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      lable: S.of(context).cancel,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: customButton(
                      onPressed: () {
                        Navigator.pop(context);
                        cubit.changeCourseTheme(themeNum: themeNum);
                      },
                      lable: S.of(context).ok,
                      color: cubit.themeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
