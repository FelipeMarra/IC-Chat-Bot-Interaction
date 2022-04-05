import 'package:chat_bot_interaction/chat_page/chat_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';
  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool firstBuilt = true;
  late ChatBotWidget chatBotWidget;

  @override
  Widget build(BuildContext context) {
    final ChatPageController controller = context.watch<ChatPageController>();

    if (firstBuilt) {
      chatBotWidget = ChatBotWidget(
        chatBot: controller.getChatBot(),
        sameUserSpacing: 3,
      );

      if (chatBotWidget.chatBot.historyMode == false) {
        controller.whatchChatEnded(chatBotWidget.chatBot);
      }

      firstBuilt = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Juliette"),
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
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed("/");
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
