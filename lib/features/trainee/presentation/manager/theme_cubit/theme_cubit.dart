import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'theme_states.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(InitialThemeState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  List<Color> list = [
    appColor,
    const Color(0xff014984),
    const Color(0xff0098E1),
    const Color(0xff655BBB),
    const Color(0xffD98426),
    const Color(0xff20613E),
    const Color(0xffC061C3),
    const Color(0xffF77E76),
    const Color(0xff71F749),
  ];

  Color themeColor = appColor;

  void changeCourseTheme({required int themeNum}) {
    themeColor = list[themeNum];
    saveCourseTheme(themeNum);
    emit(SuccessSelectThemeState());
  }
}
