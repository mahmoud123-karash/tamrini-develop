import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_states.dart';

class ManageCubit extends Cubit<ManageStates> {
  ManageCubit() : super(InitailManageState());
  static ManageCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppTheme({bool? fromSP}) {
    if (fromSP != null) {
      isDark = fromSP;
      emit(ChangeThemeState());
    } else {
      isDark = !isDark;
      saveTheme(isDark);
      emit(ChangeThemeState());
    }
  }

  String lang = getEnlish();
  void changeLanguage({required String language}) async {
    if (language == '') {
      lang = getEnlish();
      saveLanguage('');
      emit(ChangeLanguageState());
    } else {
      lang = language;
      saveLanguage(language);
      emit(ChangeLanguageState());
    }
    log(lang);
  }
}
