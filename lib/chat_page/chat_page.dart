import 'package:chat_bot_interaction/chat_page/widgets/bot_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';
import 'package:flutter_chat_composer/widgets/bot_user_open_text.dart';
import 'package:chat_bot_interaction/chat_page/widgets/user_message_widget.dart';
import 'my_chat_bot.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    ChatBot chatBot = MyChatBot().chatBot();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChatBotWidget(
        chatBot: chatBot,
        botMessageWidget: (message) => BotMessageWidget(message: message),
        botTransitionWidget: (message) => _botTransitionWidget(message),
        userMessageWidget: (message) => UserMessageWidget(message: message),
        userOpenTextWidget: _userOpenTextWidget(chatBot),
        sameUserSpacing: 3,
      ),
    );
  }

  Widget _botTransitionWidget(RichText message) {
    return Container();
  }

  BotUserOpenText _userOpenTextWidget(ChatBot chatBot) {
    TextEditingController controller = TextEditingController();
    return BotUserOpenText(
      chatBot: chatBot,
      controller: controller,
      textField: Row(
        children: [
          Flexible(child: Container()),
          Flexible(
            child: TextField(
              controller: controller,
            ),
          ),
        ],
      ),
      userMessageWidget: (message) => UserMessageWidget(message: message),
      icon: Icon(
        Icons.send,
        color: Colors.grey[500],
        size: 18,
      ),
    );
  }
}
