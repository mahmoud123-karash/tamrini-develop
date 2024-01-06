import 'package:get_it/get_it.dart';
import 'package:tamrini/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:tamrini/features/auth/data/repo/register_repo_impl.dart';
import 'package:tamrini/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:tamrini/features/auth/domain/use_cases/register_use_case.dart';
import 'package:tamrini/features/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:tamrini/features/home/data/repo/home_repo_imol.dart';
import 'package:tamrini/features/store/data/data_sources/local_data_source/store_local_data_source.dart';
import 'package:tamrini/features/store/data/data_sources/remote_data_source/store_remote_data_source.dart';
import 'package:tamrini/features/store/data/repo/store_repo_impl.dart';

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
}
