import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/chat/domain/repo/chat_repo.dart';
import 'package:tamrini/features/chat/presentation/manager/chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit(this.chatRepo) : super(InitialChatState());
  static ChatCubit get(context) => BlocProvider.of(context);

  final ChatRepo chatRepo;

  void sendMessage({
    required String uid,
    required String messageText,
    required String recieverUid,
    required String imagepath,
  }) async {
    emit(LoadingSendMessageState());
    var result = await chatRepo.sendMessage(
        uid: uid,
        messageText: messageText,
        recieverUid: recieverUid,
        imagepath: imagepath);
    result.fold((message) {
      emit(ErrorSendMessageState(message));
    }, (m) {
      emit(SuccessSendMessageState());
    });
  }
}
