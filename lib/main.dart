import 'package:chat_bot_interaction/chat_page/chatPage_controller.dart';
import 'package:chat_bot_interaction/chat_page/chat_page.dart';
import 'package:chat_bot_interaction/home_page/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';

void main() async {
  setPathUrlStrategy();
  await Hive.initFlutter();
  //TODO
  await Hive.deleteBoxFromDisk("chat_history");
  runApp(const ChatBotInteractionApp());
}

class ChatBotInteractionApp extends StatelessWidget {
  const ChatBotInteractionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => ChatPageController()),
        ),
      ],
      child: MaterialApp(
        title: "ChatBotInteractionApp",
        routes: {
          "/": (context) => const HomePage(),
          ChatPage.routeName: (context) => const ChatPage(),
        },
      ),
    );
  }
}
