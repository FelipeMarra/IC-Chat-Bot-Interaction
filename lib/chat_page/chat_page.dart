import 'package:flutter/material.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';
import 'my_chat_bot.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    ChatBot chatBot = MyChatBot().chatBot();
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatBot"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChatBotWidget(
          chatBot: chatBot,
          sameUserSpacing: 3,
        ),
      ),
    );
  }
}
