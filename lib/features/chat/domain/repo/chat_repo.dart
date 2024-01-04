import 'package:dartz/dartz.dart';
import 'package:tamrini/features/chat/data/models/message_model.dart';

abstract class ChatRepo {
  Future<Either<String, List<MessageModel>>> getMessages({required String uid});
  Future<Either<String, String>> sendMessage({
    required String uid,
    required String messageText,
    required String recieverUid,
  });
}
