import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/features/auth/domain/use_cases/register_use_case.dart';
import 'package:tamrini/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'widgets/signup_content.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        getIt.get<RegisterUseCase>(),
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesLogin1),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: whiteColor.withOpacity(0.1),
              ),
              body: const SignupContent(),
            ),
          ),
        ],
      ),
    );
  }
}
