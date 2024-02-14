import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Future<Either<String, String>> sendMessage({
    required String uid,
    required String messageText,
    required String imagepath,
    required String recieverUid,
  });
}
