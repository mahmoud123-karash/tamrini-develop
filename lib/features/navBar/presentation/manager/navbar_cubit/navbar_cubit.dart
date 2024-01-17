import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/exercise/presentation/views/exercises_types_screen.dart';
import 'package:tamrini/features/home/presentation/views/home_screen.dart';
import 'package:tamrini/features/navBar/presentation/manager/navbar_cubit/navbar_states.dart';
import 'package:tamrini/features/diet_food/presentation/views/educate_your_self_screen.dart';
import 'package:tamrini/features/store/presenrtation/views/stores_screen.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:tamrini/features/food/presentation/views/food_category_screen.dart';

class NavBarCubit extends Cubit<NavBarStates> {
  NavBarCubit() : super(InitailNavBarState());
  static NavBarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 2;
  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeIndexNavBarState());
  }

  final List<Widget> screens = [
    const FoodCategoryScreen(),
    const ExercisesTypesScreen(),
    const HomeScreen(),
    const StoresScreen(),
    const EducateYourSelfScreen(),
  ];

  List<String> titles(context) => [
        S.of(context).health,
        S.of(context).exercises,
        S.of(context).home,
        S.of(context).store,
        S.of(context).self,
      ];
}
