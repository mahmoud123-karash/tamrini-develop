import 'package:tamrini/core/cubit/user_cubit/user_cubit.dart';
import 'package:tamrini/core/cubit/user_cubit/user_states.dart';
import 'package:tamrini/core/utils/improts.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/write_answer_widget.dart';

class WriteAnswerWidgetBuilder extends StatefulWidget {
  const WriteAnswerWidgetBuilder({
    super.key,
    required this.model,
    required this.token,
    required this.scrolController,
  });
  final QuestionModel model;
  final String token;
  final ScrollController scrolController;

  @override
  State<WriteAnswerWidgetBuilder> createState() =>
      _WriteAnswerWidgetBuilderState();
}

class _WriteAnswerWidgetBuilderState extends State<WriteAnswerWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    return BlocProvider(
      create: (context) => UserCubit()..getUser(uid: uid),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is SucessGetUserState) {
            if (state.model.isBanned) {
              return Container();
            }
            return WriteAnswerWidget(
              model: widget.model,
              token: widget.token,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
