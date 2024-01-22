import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:tamrini/features/auth/data/repo/register_repo_impl.dart';
import 'package:tamrini/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:tamrini/features/auth/domain/use_cases/register_use_case.dart';
import 'package:tamrini/features/exercise/data/data_sources/remote_data_source/exercise_remote_data_source.dart';
import 'package:tamrini/features/exercise/data/repo/exercise_repo_impl.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/nutrition_remote_data_source.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/supplement_remote_data_source.dart';
import 'package:tamrini/features/food/data/repo/food_repo_Impl.dart';
import 'package:tamrini/features/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:tamrini/features/home/data/repo/home_repo_imol.dart';
import 'package:tamrini/features/diet_food/data/data_sources/remote_data_source/diet_food_remote_data_source.dart';
import 'package:tamrini/features/diet_food/data/repo/diet_food_repo_impl.dart';
import 'package:tamrini/features/my_day/data/data_sources/local_data_source/my_day_local_data_source.dart';
import 'package:tamrini/features/my_day/data/data_sources/remote_data_source/my_day_remote_data_source.dart';
import 'package:tamrini/features/my_day/data/repo/my_day_repo_impl.dart';
import 'package:tamrini/features/notification/data/data_sources/remote_data_source/notification_remote_data_source.dart';
import 'package:tamrini/features/notification/data/repo/notification_repo_impl.dart';
import 'package:tamrini/features/profile/data/data_sources/local_data_source/profile_local_data_source.dart';
import 'package:tamrini/features/profile/data/data_sources/remote_data_source/profile_remote_data_source.dart';
import 'package:tamrini/features/profile/data/repo/profile_repo_impl.dart';
import 'package:tamrini/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:tamrini/features/questions/data/repo/question_repo_impl.dart';
import 'package:tamrini/features/questions/domain/use_cases/write_answer_use_case.dart';
import 'package:tamrini/features/store/data/data_sources/local_data_source/store_local_data_source.dart';
import 'package:tamrini/features/store/data/data_sources/remote_data_source/store_remote_data_source.dart';
import 'package:tamrini/features/store/data/repo/store_repo_impl.dart';
import 'package:tamrini/features/trainer/data/data_sources/remote_data_source/trainer_remote_data_source.dart';
import 'package:tamrini/features/trainer/data/repo/trainer_repo_impl.dart';
import 'package:tamrini/features/questions/data/data_sources/remote_data_source/user_remote_data_source.dart'
    as user;
import 'package:tamrini/features/water_reminder/data/data_sources/local_data_source/reminder_local_data_source.dart';
import 'package:tamrini/features/water_reminder/data/repo/reminder_repo_impl.dart';

import '../../features/auth/data/repo/login_repo_impl.dart';

GetIt getIt = GetIt.instance;

void setLocator() {
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
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      HomeRemoteDataSourceImpl(),
    ),
  );
  getIt.registerSingleton<StoreRepoImpl>(
    StoreRepoImpl(
      StoreRemoteDataSourceImpl(),
      StoreLocalDataSourceImpl(),
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
    ),
  );

  getIt.registerSingleton<DietFoodRepoImpl>(
    DietFoodRepoImpl(
      DietFoodRemoteDataSourceImpl(),
    ),
  );

  getIt.registerSingleton<QuestionRepoImpl>(
    QuestionRepoImpl(
      user.UserRemoteDataSourceImpl(),
    ),
  );
  getIt.registerSingleton<DioHelper>(
    DioHelper(
      Dio(),
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

  getIt.registerSingleton<FoodRepoImpl>(
    FoodRepoImpl(
      SupplementRemoteDataSourceImpl(),
      NutritionRemoteDataSourceImpl(),
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
}
