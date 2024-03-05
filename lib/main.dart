import 'package:tamrini/features/questions/domain/use_cases/write_answer_use_case.dart';
import 'core/utils/improts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
  Hive.registerAdapter(SubscriptionModelAdapter());
  await Hive.openBox<SubscriptionModel>(subBox);

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
          create: (context) => UsersCubit(
            getIt.get<AdminRepoImpl>(),
          ),
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
          )..getData(),
        ),
        BlocProvider(
          create: (context) => AdMobCubit(),
        ),
        BlocProvider(
          create: (context) => SubscriptionCubit(
            getIt.get<SubscriptionRepoImpl>(),
          )..getSubscriptions(),
        ),
        BlocProvider(
            create: (context) => ProfitsCubit(
                  getIt.get<ProfitsRepoImpl>(),
                )..getData()),
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
            String lang = ManageCubit.get(context).lang == 'ar' ? 'ar' : 'en';
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
