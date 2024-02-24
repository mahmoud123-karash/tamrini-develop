import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:tamrini/features/auth/domain/use_cases/register_use_case.dart';
import 'package:tamrini/features/questions/domain/use_cases/write_answer_use_case.dart';
import '../../features/auth/data/repo/login_repo_impl.dart';
import '../../features/payment/domain/use_cases/create_transaction_id_use_case.dart';

GetIt getIt = GetIt.instance;

void setLocator() {
  getIt.registerSingleton<DioHelper>(
    DioHelper(
      Dio(),
    ),
  );

  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(
      RegisterRepoImpl(),
    ),
  );

  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      UserRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<GoogleSignInUseCase>(
    GoogleSignInUseCase(
      getIt.get<LoginRepoImpl>(),
    ),
  );

  getIt.registerSingleton<StoreRepoImpl>(
    StoreRepoImpl(
      StoreRemoteDataSourceImpl(),
      StoreLocalDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<ExerciseRepoImpl>(
    ExerciseRepoImpl(
      ExerciseRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<TrainerRepoImpl>(
    TrainerRepoImpl(
      TrainerRemoteDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<DietFoodRepoImpl>(
    DietFoodRepoImpl(
      DietFoodRemoteDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<QuestionRepoImpl>(
    QuestionRepoImpl(
      QuestionRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<GymRepoImpl>(
    GymRepoImpl(
      GymRemoteDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<WriteAnswerUseCase>(
    WriteAnswerUseCase(
      getIt.get<QuestionRepoImpl>(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<NotificationRepoImpl>(
    NotificationRepoImpl(
      NotificationRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(
      ProfileRemotedataSourceImpl(),
      ProfileLocalDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<UpdateUseCase>(
    UpdateUseCase(
      getIt.get<ProfileRepoImpl>(),
    ),
  );

  getIt.registerSingleton<NutritionRepoImpl>(
    NutritionRepoImpl(
      NutritionRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton(
    FoodRepoImpl(
      SupplementRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<MyDayRepoImpl>(
    MyDayRepoImpl(
      MyDayRemoteDataSourceImpl(),
      MyDayLocalDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<ReminderRepoImpl>(
    ReminderRepoImpl(
      ReminderLocalDataSourceImpl(),
    ),
  );

  getIt.registerSingleton(
    HomeExerciseRepoImpl(
      HomeExerciseRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<SuggestRepoIpml>(
    SuggestRepoIpml(
      SuggestRemoteDataSourceImpl(),
    ),
  );
  getIt.registerSingleton<ArticleRepoImpl>(
    ArticleRepoImpl(
      ArticleRemoteDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<OrederRepoImpl>(
    OrederRepoImpl(
      OrderRemoteDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<AdminRepoImpl>(
    AdminRepoImpl(
      AdminRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<RatingRepoImpl>(
    RatingRepoImpl(),
  );

  getIt.registerSingleton<TraineeRepoImpl>(
    TraineeRepoImpl(
      TraineeRemoteDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<PromotionRepoImpl>(
    PromotionRepoImpl(
      PromotionRemoteDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );

  getIt.registerSingleton<ChatRepoImpl>(
    ChatRepoImpl(getIt.get<DioHelper>()),
  );

  getIt.registerSingleton<FavoriteRepoImpl>(
    FavoriteRepoImpl(
      FavoriteRemoteDataSourceImpl(),
      FavoriteLocalDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<BannerRepoImpl>(
    BannerRepoImpl(
      BannerRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<CreateTranscationIdUseCase>(
    CreateTranscationIdUseCase(
      PaymentRepo(),
    ),
  );

  getIt.registerSingleton<SubscriptionRepoImpl>(
    SubscriptionRepoImpl(
      SubscriptionRemoteDataSourceImpl(),
      SubscribtionLocalDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<ProfitsRepoImpl>(
    ProfitsRepoImpl(
      ProfitsRemoteDataSourceImpl(),
      getIt.get<DioHelper>(),
    ),
  );
}
