import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/features/admin/data/remote_data_source/admin_remote_data_source.dart';
import 'package:tamrini/features/admin/data/repo/admin_repo_impl.dart';
import 'package:tamrini/features/atricle/data/data_sources/remote_data_source/article_remote_data_source.dart';
import 'package:tamrini/features/atricle/data/repo/article_repo_impl.dart';
import 'package:tamrini/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:tamrini/features/auth/data/repo/register_repo_impl.dart';
import 'package:tamrini/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:tamrini/features/auth/domain/use_cases/register_use_case.dart';
import 'package:tamrini/features/banner/data/data_sources/remote_data_source/banner_remote_data_source.dart';
import 'package:tamrini/features/chat/data/repo/chat_repo_impl.dart';
import 'package:tamrini/features/exercise/data/data_sources/remote_data_source/exercise_remote_data_source.dart';
import 'package:tamrini/features/exercise/data/repo/exercise_repo_impl.dart';
import 'package:tamrini/features/favourite/data/data_sources/local_data_source/favorite_local_data_source.dart';
import 'package:tamrini/features/favourite/data/data_sources/remote_data_source/favorite_remote_data_source.dart';
import 'package:tamrini/features/favourite/data/repo/favorite_meal_repo_impl.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/supplement_remote_data_source.dart';
import 'package:tamrini/features/food/data/repo/food_repo_impl.dart';
import 'package:tamrini/features/gym/data/data_sources/remote_data_source/gym_remote_data_source.dart';
import 'package:tamrini/features/gym/data/repo/gym_repo_impl.dart';
import 'package:tamrini/features/diet_food/data/data_sources/remote_data_source/diet_food_remote_data_source.dart';
import 'package:tamrini/features/diet_food/data/repo/diet_food_repo_impl.dart';
import 'package:tamrini/features/home_exercise/data/data_sources/remote_data_source/home_exercise_remote_data_source.dart';
import 'package:tamrini/features/my_day/data/data_sources/local_data_source/my_day_local_data_source.dart';
import 'package:tamrini/features/my_day/data/data_sources/remote_data_source/my_day_remote_data_source.dart';
import 'package:tamrini/features/my_day/data/repo/my_day_repo_impl.dart';
import 'package:tamrini/features/notification/data/data_sources/remote_data_source/notification_remote_data_source.dart';
import 'package:tamrini/features/notification/data/repo/notification_repo_impl.dart';
import 'package:tamrini/features/nutrition/data/data_source/remote_data_source/nutrition_remote_data_source.dart';
import 'package:tamrini/features/nutrition/data/repo/nutrition_repo_impl.dart';
import 'package:tamrini/features/order/data/data_sources/remote_data_source/order_remote_data_source.dart';
import 'package:tamrini/features/order/data/repo/order_repo_impl.dart';
import 'package:tamrini/features/profile/data/data_sources/local_data_source/profile_local_data_source.dart';
import 'package:tamrini/features/profile/data/data_sources/remote_data_source/profile_remote_data_source.dart';
import 'package:tamrini/features/profile/data/repo/profile_repo_impl.dart';
import 'package:tamrini/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:tamrini/features/promotion/data/data_source/remote_data_source/promotion_remote_data_source.dart';
import 'package:tamrini/features/promotion/data/repo/promotion_repo_impl.dart';
import 'package:tamrini/features/questions/data/data_sources/remote_data_source/remote_question_data_source.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/domain/use_cases/ban_question_use_case.dart';
import 'package:tamrini/features/questions/domain/use_cases/write_answer_use_case.dart';
import 'package:tamrini/features/rating/data/repo/rating_repo_impl.dart';
import 'package:tamrini/features/store/data/data_sources/local_data_source/store_local_data_source.dart';
import 'package:tamrini/features/store/data/data_sources/remote_data_source/store_remote_data_source.dart';
import 'package:tamrini/features/store/data/repo/store_repo_impl.dart';
import 'package:tamrini/features/suggest_exercise/data/data_sources/remote_data_source/suggest_remote_data_source.dart';
import 'package:tamrini/features/suggest_exercise/data/repo/suggest_repo_impl.dart';
import 'package:tamrini/features/trainee/data/data_sources/remote_data_source/trainee_remote_data_source.dart';
import 'package:tamrini/features/trainee/data/repo/trainee_repo_impl.dart';
import 'package:tamrini/features/trainer/data/data_sources/remote_data_source/trainer_remote_data_source.dart';
import 'package:tamrini/features/trainer/data/repo/trainer_repo_impl.dart';

import 'package:tamrini/features/water_reminder/data/data_sources/local_data_source/reminder_local_data_source.dart';
import 'package:tamrini/features/water_reminder/data/repo/reminder_repo_impl.dart';

import '../../features/auth/data/repo/login_repo_impl.dart';
import '../../features/banner/data/repo/banner_repo_impl.dart';
import '../../features/home_exercise/data/repo/home_exercise_repo_impl.dart';

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

  getIt.registerSingleton<BanQuestionUseCase>(
    BanQuestionUseCase(
      getIt.get<QuestionRepoImpl>(),
      getIt.get<DioHelper>(),
      QuestionRemoteDataSourceImpl(),
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

  getIt.registerSingleton(
    FavoriteRepoImpl(
      FavoriteRemoteDataSourceImpl(),
      FavoriteLocalDataSourceImpl(),
    ),
  );

  getIt.registerSingleton(
    BannerRepoImpl(
      BannerRemoteDataSourceImpl(),
    ),
  );
}
