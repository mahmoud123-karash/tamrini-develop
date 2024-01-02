import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/provider/artical_provider.dart';
import 'package:tamrini/provider/diet_food_provider.dart';
import 'package:tamrini/provider/questions_proviser.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/Articles_screens/Articles_screen.dart';
import 'package:tamrini/screens/diet_food_screens/diet_food_screen.dart';
import 'package:tamrini/screens/login_screen/login_screen.dart';
import 'package:tamrini/screens/question_screens/questions_screen.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

class ArticlesCategoryScreen extends StatefulWidget {
  const ArticlesCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesCategoryScreen> createState() => _ArticlesCategoryScreenState();
}

class _ArticlesCategoryScreenState extends State<ArticlesCategoryScreen> {
  @override
  void didChangeDependencies() {
    precacheImage(
        const AssetImage("assets/images/articalesBanner.jpg"), context);
    precacheImage(const AssetImage("assets/images/diet.jpg"), context);
    precacheImage(const AssetImage("assets/images/question.jpg"), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // searchBar(_searchController, (p0) => null),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<ArticleProvider>(context, listen: false)
                  .fetchAndSetArticles();
              Provider.of<ArticleProvider>(context, listen: false)
                  .fetchAndSetPendingArticles();
              To(const ArticlesScreen());
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/articalesBanner.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints(
                minHeight: 100.h,
                maxHeight: 200.h,
                maxWidth: double.infinity,
                minWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "المقالات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<DietFoodProvider>(context, listen: false)
                  .fetchAndSetMeals();
              Provider.of<DietFoodProvider>(context, listen: false)
                  .fetchAndSetPendingMeal();
              To(const DietFoodScreen());
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/diet.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints(
                minHeight: 100.h,
                maxHeight: 200.h,
                maxWidth: double.infinity,
                minWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "أكــلات دايــت",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              !Provider.of<UserProvider>(context, listen: false).isLogin
                  ? AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.bottomSlide,
                      title: 'تنبيه',
                      desc: 'يجب عليك تسجيل الدخول اولا للمتابعة',
                      btnCancelOnPress: () {
                        // pop();
                      },
                      btnOkOnPress: () {
                        To(const LoginScreen());
                      },
                    ).show()
                  : {
                      Provider.of<QuestionsProvider>(context, listen: false)
                          .fetchQuestions(),
                      To(const QuestionsScreen())
                    };
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/question.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints(
                minHeight: 100.h,
                maxHeight: 200.h,
                maxWidth: double.infinity,
                minWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "الأسئلة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
