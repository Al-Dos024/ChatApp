// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:chat_app/Widgets/Chat_Bubble.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/chat_cubit.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'Chat Page';
  final _controller = ScrollController();
  List<Message> messageList = [];

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/RedSus.png',
              height: 50,
            ),
            const Text('Chat')
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messageList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return messageList[index].id == email
                        ? chatBubble(
                            message: messageList[index],
                          )
                        : chatBubbleFromfriend(message: messageList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(seconds: 5), curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message ',
                suffixIcon: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: kPrimaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
