import 'package:chat_bot_interaction/chat_page/chat_page.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';

import 'home_page/home_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(const ChatBotInteractionApp());
}

class ChatBotInteractionApp extends StatelessWidget {
  const ChatBotInteractionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatBotInteractionApp",
      routes: {
        "/": (context) => const HomePage(),
        ChatPage.routeName: (context) => const ChatPage(),
      },
    );
  }
}
