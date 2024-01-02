import 'package:get_it/get_it.dart';
import 'package:tamrini/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:tamrini/features/auth/data/repo/register_repo_impl.dart';
import 'package:tamrini/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:tamrini/features/auth/domain/use_cases/register_use_case.dart';

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
}
