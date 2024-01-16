import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tamrini/core/cache/shared_preference.dart' as helper;
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/services/internet_connection.dart';
import 'package:tamrini/core/services/request_premission.dart';
import 'package:tamrini/core/shared/bloc_observer.dart';
import 'package:tamrini/data/location.dart';

import 'package:tamrini/features/exercise/data/repo/exercise_repo_impl.dart';
import 'package:tamrini/features/exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/home/data/repo/home_repo_imol.dart';
import 'package:tamrini/features/home/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/navBar/domain/repo/navbar_repo.dart';
import 'package:tamrini/features/profile/presentation/manager/location_cubit/location_cubit.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_cubit.dart';
import 'package:tamrini/features/settings/presentation/manager/manage_cubit/manage_states.dart';
import 'package:tamrini/features/navBar/presentation/manager/update_cubit/update_cubit.dart';
import 'package:tamrini/features/navBar/presentation/views/navabar_screen.dart';
import 'package:tamrini/features/diet_food/data/repo/diet_food_repo_impl.dart';
import 'package:tamrini/features/diet_food/presentation/manager/article_cubit/diet_foood_cubit.dart';
import 'package:tamrini/features/notification/data/repo/notification_repo_impl.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/profile/data/repo/profile_repo_impl.dart';
import 'package:tamrini/features/profile/domain/repo/profile_repo.dart';
import 'package:tamrini/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:tamrini/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/domain/use_cases/write_answer_use_case.dart';
import 'package:tamrini/features/questions/presentation/manager/question_cubit/question_cubit.dart';
import 'package:tamrini/features/store/data/models/category_model.dart';
import 'package:tamrini/features/store/data/repo/store_repo_impl.dart';
import 'package:tamrini/features/store/presenrtation/manager/article_cubit/category_cubit.dart';
import 'package:tamrini/features/trainer/data/repo/trainer_repo_impl.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/firebase_options.dart';
import 'package:tamrini/model/home_exercise.dart' as homeExercises;
import 'package:tamrini/model/product.dart';
import 'package:tamrini/provider/ThemeProvider.dart';
import 'package:tamrini/provider/Upload_Image_provider.dart';
import 'package:tamrini/provider/artical_provider.dart';
import 'package:tamrini/provider/diet_food_provider.dart';
import 'package:tamrini/provider/exercise_provider.dart';
import 'package:tamrini/provider/gym_provider.dart';
import 'package:tamrini/provider/home_exercise_provider.dart';
import 'package:tamrini/provider/home_provider.dart';
import 'package:tamrini/provider/nutritious_value_provider.dart';
import 'package:tamrini/provider/product_provider.dart';
import 'package:tamrini/provider/proten_calculator_provider.dart';
import 'package:tamrini/provider/questions_proviser.dart';
import 'package:tamrini/provider/supplement_provider.dart';
import 'package:tamrini/provider/trainee_provider.dart';
import 'package:tamrini/provider/trainer_provider.dart';
import 'package:tamrini/provider/user_provider.dart';
import 'package:tamrini/screens/Articles_screens/Article_details_screen.dart';
import 'package:tamrini/screens/Articles_screens/Articles_screen.dart';
import 'package:tamrini/screens/ProteinCalc_Screen.dart';
import 'package:tamrini/screens/diet_food_screens/diet_food_details_screen.dart';
import 'package:tamrini/screens/diet_food_screens/diet_food_screen.dart';
import 'package:tamrini/screens/exercises_screens/exercise_Article_details_screen.dart';
import 'package:tamrini/screens/exercises_screens/exercises_home_screen.dart';
import 'package:tamrini/screens/gym_screens/gym_details_screen.dart';
import 'package:tamrini/screens/gym_screens/gyms_screen.dart';
import 'package:tamrini/screens/home_exercises_screens/home_exercise_Article_details_Screen.dart';
import 'package:tamrini/screens/home_exercises_screens/home_exercises_home_screen.dart';
import 'package:tamrini/screens/nutritious_Screen.dart';
import 'package:tamrini/screens/products_screens/product_details_screen.dart';
import 'package:tamrini/screens/products_screens/store_home_screen.dart';
import 'package:tamrini/screens/question_screens/question_details_screen.dart';
import 'package:tamrini/screens/question_screens/questions_screen.dart';
import 'package:tamrini/screens/supplement_screens/supplements_Article_details_screen.dart';
import 'package:tamrini/screens/supplement_screens/supplements_screen.dart';
import 'package:tamrini/screens/trainer_screens/trainer_home_screen.dart';
import 'package:tamrini/screens/trainer_screens/trainer_profile_screen.dart';
import 'package:tamrini/core/styles/themes.dart';
import 'package:tamrini/utils/cache_helper.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';
import 'features/auth/presentation/views/login_screen.dart';
import 'features/questions/presentation/manager/answer_cubit/answer_cubit.dart';
import 'model/exercise.dart';
import 'model/supplement.dart';
import 'generated/l10n.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppleNotificationSetting.enabled;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var token = await messaging.getToken();

  log('current token is $token');
  if (message.data['token'] != token) {
    log('token is not the same');
    log('token is ${message.data['token']}');
    return;
  }
  log('token is the same');
  log('delivered token is ${message.data['token']}');
}

void _handleMessage(RemoteMessage message) {
  Future.delayed(const Duration(seconds: 0), () async {
    print('message is ${message.data}');

    if (message.data['type'] == 'Products') {
      var title = message.data['title'];
      if (title == null) {
        To(const ProductsHomeScreen());
        return;
      }
      while (Provider.of<ProductProvider>(navigationKey.currentContext!,
              listen: false)
          .allProducts
          .data!
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      var product = Provider.of<ProductProvider>(navigationKey.currentContext!,
              listen: false)
          .allProducts
          .data!
          .where((element) => element.title!.contains(title))
          .toList();

      if (product.isEmpty) {
        To(const ProductsHomeScreen());
        return;
      }

      To(ProductDetailsScreen(
          product: product.first, category: Product(id: ""), isAll: true));
    }
    if (message.data['type'] == 'Articles') {
      var title = message.data['title'];
      if (title == null) {
        To(const ArticlesScreen());
        return;
      }
      while (Provider.of<ArticleProvider>(navigationKey.currentContext!,
              listen: false)
          .articles
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      var article = Provider.of<ArticleProvider>(navigationKey.currentContext!,
              listen: false)
          .articles
          .where((element) => element.title!.contains(title))
          .toList();

      if (article.isEmpty) {
        To(const ArticlesScreen());
        return;
      }
      To(ArticleDetailsScreen(
          article: article.first, type: "existing", isAll: true));
    }
    if (message.data['type'] == 'Supplements') {
      var title = message.data['title'];
      if (title == null) {
        To(const SupplementsHomeScreen());
        return;
      }
      while (Provider.of<SupplementProvider>(navigationKey.currentContext!,
              listen: false)
          .allSupplements
          .data!
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      var supplement = Provider.of<SupplementProvider>(
              navigationKey.currentContext!,
              listen: false)
          .allSupplements
          .data!
          .where((element) => element.title!.contains(title))
          .toList();

      if (supplement.isEmpty) {
        To(const SupplementsHomeScreen());
        return;
      }
      To(SupplementArticlesDetailsScreen(
          supplement: supplement.first, category: Supplement(id: "")));
    }
    if (message.data['type'] == 'Gyms') {
      var title = message.data['title'];

      if (title == null) {
        To(const GymsScreen());
        return;
      }
      while (
          Provider.of<GymProvider>(navigationKey.currentContext!, listen: false)
              .gyms
              .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      var gym =
          Provider.of<GymProvider>(navigationKey.currentContext!, listen: false)
              .gyms
              .where((element) => element.name.contains(title))
              .toList();

      if (gym.isEmpty) {
        To(const GymsScreen());
        return;
      }
      To(GymDetailsScreen(gym: gym.first, isAll: true));
    }
    if (message.data['type'] == 'Trainers') {
      var title = message.data['title'];
      if (title == null) {
        To(const TrainerHomeScreen());
        return;
      }

      while (Provider.of<TrainerProvider>(navigationKey.currentContext!,
              listen: false)
          .trainers
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 2));
      }
      print('trainers is null');

      print("message title" + title);
      print(
          "trainerss : ${Provider.of<TrainerProvider>(navigationKey.currentContext!, listen: false).trainers}");

      var trainer = Provider.of<TrainerProvider>(navigationKey.currentContext!,
              listen: false)
          .trainers
          .where((element) => element.name!.contains(title))
          .toList();
      if (trainer.isEmpty) {
        print('trainer is empty');
        To(const TrainerHomeScreen());
        return;
      }
      To(TrainerProfileScreen(trainer: trainer.first));
    }
    if (message.data['type'] == 'HomeExercises') {
      var title = message.data['title'];
      if (title == null) {
        To(const HomeExercisesHomeScreen());
        return;
      }
      while (Provider.of<HomeExerciseProvider>(navigationKey.currentContext!,
              listen: false)
          .allExercises
          .data!
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      var homeExercise = Provider.of<HomeExerciseProvider>(
              navigationKey.currentContext!,
              listen: false)
          .allExercises
          .data!
          .where((element) => element.title!.contains(title))
          .toList();

      if (homeExercise.isEmpty) {
        To(const HomeExercisesHomeScreen());
        return;
      }
      To(HomeExerciseArticlesDetailsScreen(
        exercise: homeExercise.first,
        isAll: true,
        category: homeExercises.HomeExercise(id: "0"),
      ));
    }
    if (message.data['type'] == 'Exercises') {
      var title = message.data['title'];
      if (title == null) {
        To(const ExercisesHomeScreen());
        return;
      }
      while (Provider.of<ExerciseProvider>(navigationKey.currentContext!,
              listen: false)
          .allExercises
          .data!
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      var exercise = Provider.of<ExerciseProvider>(
              navigationKey.currentContext!,
              listen: false)
          .allExercises
          .data!
          .where((element) => element.title!.contains(title))
          .toList();
      if (exercise.isEmpty) {
        To(const ExercisesHomeScreen());
        return;
      }
      To(ExerciseArticlesDetailsScreen(
        exercise: exercise.first,
        isAll: true,
        category: Exercise(id: "0"),
      ));
    }
    if (message.data['type'] == 'DietFoods') {
      var title = message.data['title'];
      if (title == null) {
        To(const DietFoodScreen());
        return;
      }
      while (Provider.of<DietFoodProvider>(navigationKey.currentContext!,
              listen: false)
          .foodList
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      var dietFood = Provider.of<DietFoodProvider>(
              navigationKey.currentContext!,
              listen: false)
          .foodList
          .where((element) => element.title.contains(title))
          .toList();

      if (dietFood.isEmpty) {
        To(const DietFoodScreen());
        return;
      }
      To(DietFoodDetailsScreen(
        dietfood: dietFood.first,
        type: "existing",
      ));
    }
    if (message.data['type'] == 'NutritiousValues') {
      while (Provider.of<NutritionalValueProvider>(
              navigationKey.currentContext!,
              listen: false)
          .nutritiousList
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      To(const NutritiousCalcScreen());
    }
    if (message.data['type'] == 'ProtenCalculators') {
      To(const ProteinCalculatorScreen());
    }
    if (message.data['type'] == 'Questions') {
      var title = message.data['title'];
      if (title == null) {
        To(const QuestionsScreen());
        return;
      }
      while (Provider.of<QuestionsProvider>(navigationKey.currentContext!,
              listen: false)
          .filteredQuestions
          .isEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }
      Provider.of<QuestionsProvider>(navigationKey.currentContext!,
                      listen: false)
                  .filteredQuestions
                  .indexWhere((element) => element.title.contains(title)) !=
              -1
          ? To(QuestionDetailsScreen(
              indexs: Provider.of<QuestionsProvider>(
                      navigationKey.currentContext!,
                      listen: false)
                  .filteredQuestions
                  .indexWhere((element) => element.title.contains(title)),
            ))
          : To(const QuestionsScreen());
    }
  });
}

Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen

  if (initialMessage != null) {
    print("print appp from initialMessage ${initialMessage.data}");
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("print appp from message ${message.data}");
    _handleMessage(message);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await helper.CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setLocator();
  checkInternet();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<CategoryModel>(storeBox);
  Hive.registerAdapter(ProfileModelAdapter());
  await Hive.openBox<ProfileModel>(profileBox);
  checkInternet();
  requestAppPermissions();
  AwesomeNotifications().initialize(
    '',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: appColor,
        ledColor: Colors.white,
      )
    ],
    debug: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  bool isLoggedIn = CacheHelper.getBoolean(key: 'isLogin');

  String uid = helper.CacheHelper.getData(key: 'uid') ?? '';
  Widget? startWidget;

  if (uid == '') {
    startWidget = const LoginScreen();
  } else {
    startWidget = const NavBarScreen();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationController>(
          create: (_) => LocationController(),
        ),
        ChangeNotifierProvider<ArticleProvider>(
          create: (_) => ArticleProvider()..fetchAndSetArticles(),
        ),
        ChangeNotifierProvider<DietFoodProvider>(
          create: (_) => DietFoodProvider()..fetchAndSetMeals(),
        ),
        ChangeNotifierProvider<UploadProvider>(
          create: (_) => UploadProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider()..initiate(),
        ),
        ChangeNotifierProvider<SupplementProvider>(
          create: (_) => SupplementProvider()..fetchAndSetSupplements(),
        ),
        ChangeNotifierProxyProvider<UserProvider, ProductProvider>(
          create: (_) => ProductProvider()..fetchAndSetProducts(),
          update: (_, userProvider, productProvider) =>
              productProvider!..initiate(userProvider),
        ),
        ChangeNotifierProvider<GymProvider>(
            create: (_) => GymProvider()..fetchAndSetGyms()),
        ChangeNotifierProvider<HomeExerciseProvider>(
          create: (_) => HomeExerciseProvider()..fetchAndSetExercise(),
        ),
        ChangeNotifierProvider<QuestionsProvider>(
          create: (_) => QuestionsProvider()..fetchQuestions(),
        ),
        ChangeNotifierProvider<ProteinCalculatorProvider>(
          create: (_) => ProteinCalculatorProvider(),
        ),
        ChangeNotifierProvider<NutritionalValueProvider>(
          create: (_) => NutritionalValueProvider()..initiate(),
        ),
        ChangeNotifierProvider<ExerciseProvider>(
          create: (_) => ExerciseProvider()..fetchAndSetExercise(),
        ),
        ChangeNotifierProxyProvider<UserProvider, TrainerProvider>(
          create: (_) => TrainerProvider()..fetchAndSetTrainers(),
          update: (_, userProvider, trainerProvider) =>
              trainerProvider!..initiate(userProvider),
        ),
        ChangeNotifierProxyProvider3<ExerciseProvider, UserProvider,
            SupplementProvider, TraineeProvider>(
          create: (_) => TraineeProvider(),
          update: (_, exerciseProvider, userProvider, supplementProvider,
                  traineeProvider) =>
              traineeProvider!
                ..initiate(
                  userProvider,
                  exerciseProvider,
                  supplementProvider,
                ),
        ),
        ChangeNotifierProxyProvider5<UserProvider, ExerciseProvider,
            ArticleProvider, GymProvider, ProductProvider, HomeProvider>(
          create: (_) => HomeProvider(),
          update: (_, userProvider, exerciseProvider, articleProvider,
                  gymProvider, productProvider, homeProvider) =>
              homeProvider!
                ..init(
                  userProvider: userProvider,
                  exerciseProvider: exerciseProvider,
                  articleProvider: articleProvider,
                  gymProvider: gymProvider,
                  productProvider: productProvider,
                ),
        ),
      ],
      child: MultiBlocProvider(
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
              getIt.get<HomeRepoImpl>(),
            )..getData(),
          ),
          BlocProvider(
            create: (context) => ArticlesCubit(
              getIt.get<HomeRepoImpl>(),
            )..getData(),
          ),
          BlocProvider(
            create: (context) => GymCubit(
              getIt.get<HomeRepoImpl>(),
            )..getData(update: false),
          ),
          BlocProvider(
            create: (context) => StoreCubit(
              getIt.get<HomeRepoImpl>(),
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
              getIt.get<ExerciseRepoImpl>(),
            )..getData(),
          ),
          BlocProvider(
            create: (context) => QuestionCubit(
              getIt.get<QuestionRepoImpl>(),
            ),
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
            )..getData(),
          ),
          BlocProvider(
            create: (context) => ManageCubit()
              ..changeAppTheme(
                fromSP: helper.CacheHelper.getData(key: 'isdark') ?? false,
              )
              ..changeLanguage(
                language: helper.CacheHelper.getData(key: 'lang') ?? '',
              ),
          )
        ],
        child: MyApp(
          isDark: isDark,
          isLogged: isLoggedIn,
          startWidget: startWidget,
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final isDark;
  final isLogged;
  final Widget startWidget;

  const MyApp({
    super.key,
    this.isDark,
    this.isLogged,
    required this.startWidget,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LocationController(), fenix: true);
    return ScreenUtilInit(
      builder: (_, __) {
        return ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider()
            ..init()
            ..changeAppMode(fromShared: widget.isDark),
          builder: (context, obj) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .addTabCalculator();
              },
              child: BlocBuilder<ManageCubit, ManageStates>(
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
              ),
            );
          },
        );
      },
    );
  }
}
