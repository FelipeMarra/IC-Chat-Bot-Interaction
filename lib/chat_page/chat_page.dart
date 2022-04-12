import 'package:chat_bot_interaction/chat_page/chat_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';
  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const String botFace = "assets/images/bot_face.png";
  bool firstBuilt = true;
  late ChatBotWidget chatBotWidget;

  @override
  Widget build(BuildContext context) {
    final ChatPageController controller = context.watch<ChatPageController>();

    if (firstBuilt) {
      chatBotWidget = ChatBotWidget(
        chatBot: controller.getChatBot(),
        sameUserSpacing: 3,
        botFace: Image.asset(
          botFace,
          filterQuality: FilterQuality.high,
        ),
      );

      if (chatBotWidget.chatBot.historyMode == false) {
        controller.whatchChatEnded(chatBotWidget.chatBot);
      }

      firstBuilt = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: Image.asset(
                botFace,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(width: 10),
            const Text("Juliette"),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 14,
            fit: FlexFit.loose,
            child: chatBotWidget,
          ),
          //Show finalized button when the chat ends
          controller.chatEnded || chatBotWidget.chatBot.historyMode
              ? Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: const Text("Finalizar"),
                          onPressed: () async {
                            if (chatBotWidget.chatBot.historyMode) {
                              Navigator.of(context).pop();
                            } else {
                              launch("https://forms.gle/SrCMSX8ZYRZjXv6Y9");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
