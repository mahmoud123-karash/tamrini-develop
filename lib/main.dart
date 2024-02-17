import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/cubit/image_cubit/image_cubit.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/services/internet_connection.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/core/services/messaging.dart';
import 'package:tamrini/core/services/request_premission.dart';
import 'package:tamrini/core/shared/bloc_observer.dart';
import 'package:tamrini/core/utils/awesome_notification.dart';
import 'package:tamrini/features/admin/data/repo/admin_repo_impl.dart';
import 'package:tamrini/features/admin/presentation/manager/user_cubit/users_cubit.dart';
import 'package:tamrini/features/atricle/data/repo/article_repo_impl.dart';
import 'package:tamrini/features/banner/data/repo/banner_repo_impl.dart';
import 'package:tamrini/features/banner/presentation/manager/banner_cubit/banner_cubit.dart';

import 'package:tamrini/features/exercise/data/repo/exercise_repo_impl.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/data/repo/favorite_meal_repo_impl.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_cubit.dart';
import 'package:tamrini/features/home_exercise/data/repo/home_exercise_repo_impl.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/food/data/repo/food_repo_impl.dart';
import 'package:tamrini/features/nutrition/data/repo/nutrition_repo_impl.dart';
import 'package:tamrini/features/nutrition/presentation/manager/classification_cubit/classification_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/manager/nutrition_cubit/nutrition_cubit.dart';
import 'package:tamrini/features/nutrition/presentation/manager/select_cubit.dart/select_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/gym/data/repo/gym_repo_impl.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/order/data/repo/order_repo_impl.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tamrini/features/promotion/data/repo/promotion_repo_impl.dart';
import 'package:tamrini/features/promotion/presentation/manager/promotion_cubit/promotion_cubit.dart';
import 'package:tamrini/features/rating/data/repo/rating_repo_impl.dart';
import 'package:tamrini/features/rating/presentation/manager/store_cubit/rating_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/my_day/data/models/day_model/calculator_model.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/data/models/day_model/nutrient.dart';
import 'package:tamrini/features/my_day/data/repo/my_day_repo_impl.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';
import 'package:tamrini/features/navBar/domain/repo/navbar_repo.dart';
import 'package:tamrini/features/profile/presentation/manager/location_cubit/location_cubit.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_cubit.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_states.dart';
import 'package:tamrini/features/navBar/presentation/manager/update_cubit/update_cubit.dart';
import 'package:tamrini/features/navBar/presentation/views/navbar_screen.dart';
import 'package:tamrini/features/diet_food/data/repo/diet_food_repo_impl.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_cubit.dart';
import 'package:tamrini/features/notification/data/repo/notification_repo_impl.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/data/repo/profile_repo_impl.dart';
import 'package:tamrini/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/domain/use_cases/write_answer_use_case.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_cubit.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/data/repo/store_repo_impl.dart';
import 'package:tamrini/features/store/presentation/manager/category_cubit/category_cubit.dart';
import 'package:tamrini/features/suggest_exercise/data/repo/suggest_repo_impl.dart';
import 'package:tamrini/features/suggest_exercise/presentation/manager/suggest_cubit/suggest_cubit.dart';
import 'package:tamrini/features/trainee/data/repo/trainee_repo_impl.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/features/trainer/data/repo/trainer_repo_impl.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/water_reminder/data/repo/reminder_repo_impl.dart';
import 'package:tamrini/features/water_reminder/presentaion/manager/reminder_cubit/reminder_cubit.dart';
import 'package:tamrini/firebase_options.dart';
import 'package:tamrini/core/styles/themes.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';
import 'features/auth/presentation/views/login_screen.dart';
import 'features/my_day/data/models/day_model/times_model.g.dart';
import 'features/order/presentation/manager/user_order_cubit/user_order_cubit.dart';
import 'features/questions/domain/use_cases/ban_question_use_case.dart';
import 'features/questions/presentation/manager/answer_cubit/answer_cubit.dart';
import 'features/water_reminder/data/models/reminder_model/reminder_model.dart';
import 'features/water_reminder/data/models/reminder_model/date_time.g.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<CategoryModel>(storeBox);
  Hive.registerAdapter(ProfileModelAdapter());
  await Hive.openBox<ProfileModel>(profileBox);
  Hive.registerAdapter(DayModelAdapter());
  Hive.registerAdapter(TimestampAdapter());
  Hive.registerAdapter(CalculatorModelAdapter());
  Hive.registerAdapter(NutrientAdapter());
  await Hive.openBox<DayModel>(dayBox);
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(DateTimeAdapter());
  await Hive.openBox<ReminderModel>(reminderBox);
  Hive.registerAdapter(MealModelAdapter());
  await Hive.openBox<MealModel>(favoriteBox);

  determinePosition();
  setLocator();
  checkInternet();
  requestAppPermissions();
  initializeNotifications();

  FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  String uid = CacheHelper.getData(key: 'uid') ?? '';
  Widget? startWidget;

  if (uid == '') {
    startWidget = const LoginScreen();
  } else {
    startWidget = const NavBarScreen();
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationCubit()..getLocationAddress(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(
            getIt.get<ProfileRepoImpl>(),
            getIt.get<UpdateUseCase>(),
          )..getProfile(),
        ),
        BlocProvider(
          create: (context) => UpdateCubit(
            NavBarRepo(),
          ),
        ),
        BlocProvider(
          create: (context) => ExerciseCubit(
            getIt.get<ExerciseRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => ArticlesCubit(
            getIt.get<ArticleRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => GymCubit(
            getIt.get<GymRepoImpl>(),
          )..getData(update: false),
        ),
        BlocProvider(
          create: (context) => StoreCubit(
            getIt.get<StoreRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => TrainersCubit(
            getIt.get<TrainerRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(
            getIt.get<StoreRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => DietFoodCubit(
            getIt.get<DietFoodRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => HomeExerciseCubit(
            getIt.get<HomeExerciseRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => QuestionCubit(
            getIt.get<QuestionRepoImpl>(),
            getIt.get<BanQuestionUseCase>(),
          )..getQuestions(),
        ),
        BlocProvider(
          create: (context) => AnswerCubit(
            getIt.get<QuestionRepoImpl>(),
            getIt.get<WriteAnswerUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(
            getIt.get<NotificationRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => SupplementCubit(
            getIt.get<FoodRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => ClassificationCubit(
            getIt.get<NutritionRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => NutritionCubit(
            getIt.get<NutritionRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => SelectCubit(),
        ),
        BlocProvider(
          create: (context) => DayCubit(
            getIt.get<MyDayRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => SuggestCubit(
            getIt.get<SuggestRepoIpml>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(
            getIt.get<OrederRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => UserOrderCubit(
            getIt.get<OrederRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => ReminderCubit(
            getIt.get<ReminderRepoImpl>(),
          )..getData(),
        ),
        BlocProvider(
          create: (context) => SubscriberCubit(
            getIt.get<GymRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => UsersCubit(
            getIt.get<AdminRepoImpl>(),
          )..getUsers(),
        ),
        BlocProvider(
          create: (context) => TraineeCubit(
            getIt.get<TraineeRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => UserCourseCubit(
            getIt.get<TraineeRepoImpl>(),
          )..getCourse(),
        ),
        BlocProvider(
          create: (context) => PromotionCubit(
            getIt.get<PromotionRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => CourseCubit(),
        ),
        BlocProvider(
          create: (context) => RatingCubit(
            RatingRepoImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(
            getIt.get<FavoriteRepoImpl>(),
          ),
        ),
         BlocProvider(
          create: (context) => BannerCubit(
            getIt.get<BannerRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => ManageCubit()
            ..changeAppTheme(
              fromSP: CacheHelper.getData(key: 'isdark') ?? false,
            )
            ..changeLanguage(
              language: CacheHelper.getData(key: 'lang') ?? '',
            ),
        )
      ],
      child: MyApp(
        startWidget: startWidget,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget startWidget;

  const MyApp({
    super.key,
    required this.startWidget,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, __) {
        return BlocBuilder<ManageCubit, ManageStates>(
          builder: (context, state) {
            bool isDark = ManageCubit.get(context).isDark;
            String lang = ManageCubit.get(context).lang;
            return MaterialApp(
              locale: Locale(lang),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: isDark ? darkTheme : lightTheme,
              home: widget.startWidget,
              navigatorKey: navigationKey,
            );
          },
        );
      },
    );
  }
}
