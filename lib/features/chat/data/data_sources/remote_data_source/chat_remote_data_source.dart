import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<MessageModel>> get({required String uid});
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  @override
  Future<List<MessageModel>> get({required String uid}) async {
    List<MessageModel> messages = [];
    var result = await FirebaseFirestore.instance
        .collection('Chats')
        .doc(uid)
        .collection('Messages')
        .orderBy('time')
        .get();

    for (var element in result.docs) {
      MessageModel model = MessageModel.fromJson(element.data());
      messages.add(model);
    }

    return messages;
  }
}
