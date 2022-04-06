import 'package:chat_bot_interaction/admin_page/admin_page.dart';
import 'package:chat_bot_interaction/chat_page/chat_page_controller.dart';
import 'package:chat_bot_interaction/chat_page/chat_page.dart';
import 'package:chat_bot_interaction/consent_form_page/consent_form_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          "/": (context) => const ConsentFormPage(),
          ChatPage.routeName: (context) => const ChatPage(),
          AdminPage.routeName: (context) => const AdminPage(),
        },
      ),
    );
  }
}
