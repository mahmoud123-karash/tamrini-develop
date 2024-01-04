import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/chat/data/models/message_model.dart';
import 'package:tamrini/features/chat/domain/repo/chat_repo.dart';
import 'package:tamrini/features/chat/presentation/manager/chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit(this.chatRepo) : super(InitialChatState());
  static ChatCubit get(context) => BlocProvider.of(context);

  final ChatRepo chatRepo;
  List<MessageModel> messages = [];

  void sendMessage({
    required String uid,
    required String messageText,
    required String recieverUid,
  }) async {
    emit(LoadingSendMessageState());
    var result = await chatRepo.sendMessage(
      uid: uid,
      messageText: messageText,
      recieverUid: recieverUid,
    );
    result.fold((message) {
      emit(ErrorSendMessageState(message));
    }, (m) {
      String myuid = CacheHelper.getData(key: 'uid');
      MessageModel model = MessageModel(
        message: messageText,
        senderUid: myuid,
        recieverUid: recieverUid,
        time: Timestamp.now(),
        uid: uid,
      );
      messages.add(model);
      messages.reversed.toList();
      emit(SuccessSendMessageState());
    });
  }

  void getMessages({
    required String uid,
  }) async {
    emit(LoadingSendMessageState());
    var result = await chatRepo.getMessages(
      uid: uid,
    );
    result.fold((message) {
      emit(ErrorSendMessageState(message));
    }, (list) {
      messages = list;
      emit(SuccessSendMessageState());
    });
  }
}
