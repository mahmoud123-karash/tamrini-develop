import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/features/chat/data/models/message_model.dart';
import 'package:tamrini/features/chat/domain/repo/chat_repo.dart';
import 'package:uuid/uuid.dart';

class ChatRepoImpl extends ChatRepo {
  final DioHelper dioHelper;

  ChatRepoImpl(this.dioHelper);
  @override
  Future<Either<String, String>> sendMessage({
    required String uid,
    required String messageText,
    required String imagepath,
    required String recieverUid,
  }) async {
    try {
      var messageuid = const Uuid().v4();
      String senderUid = CacheHelper.getData(key: 'uid');
      MessageModel message = MessageModel(
        message: messageText,
        senderUid: senderUid,
        image: imagepath,
        recieverUid: recieverUid,
        time: Timestamp.now(),
        uid: messageuid,
      );

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(uid)
          .collection('data')
          .doc(messageuid)
          .set(
            message.toJson(),
          );

      await sendNotification(
          senderId: senderUid, recieverId: recieverUid, chatId: uid);
      return right('Sended');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification({
    required String senderId,
    required String recieverId,
    required String chatId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'message',
      senderUid: senderId,
      title: 'message',
      body: '',
      type: 'notification',
      uid: chatId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(recieverId)
        .collection('data')
        .doc(chatId)
        .set(
          notification.toJson(),
        );
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'رسالة جديدة',
        body: 'لديك رسائل جديدة',
        data: {
          "type": "notification",
          "subType": "message",
          "uid": chatId,
        },
      );
    }
  }
}
