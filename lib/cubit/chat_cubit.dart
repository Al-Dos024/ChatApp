// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  List<Message> messageList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add(
        {kmessage: message, kCreatedAt: DateTime.now(), 'id': email},
      );
    } on Exception catch (ex) {
      print(ex.toString());
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
