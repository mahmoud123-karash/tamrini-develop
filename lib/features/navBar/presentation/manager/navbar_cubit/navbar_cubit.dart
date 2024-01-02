import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/presentation/views/home_screen.dart';
import 'package:tamrini/features/navBar/presentation/manager/navbar_cubit/navbar_states.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:tamrini/screens/articles_category_screen.dart';
import 'package:tamrini/screens/exercise_category_screen.dart';
import 'package:tamrini/screens/food_category_screen.dart';
import 'package:tamrini/screens/home_screen_body.dart';
import 'package:tamrini/screens/products_screens/store_home_screen.dart';

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
    const ExerciseCategoryScreen(),
    const HomeScreen(),
    const ProductsHomeScreen(),
    const ArticlesCategoryScreen(),
  ];

  List<String> titles(context) => [
        S.of(context).health,
        S.of(context).exercises,
        S.of(context).home,
        S.of(context).store,
        S.of(context).self,
      ];
}
