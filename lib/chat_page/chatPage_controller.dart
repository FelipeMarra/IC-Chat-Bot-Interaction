import 'package:chat_bot_interaction/chat_page/my_chat_bot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatPageController extends ChangeNotifier {
  late ChatBot Function() getChatBot;
  String id = "";

  Future<void> start(String newId) async {
    id = newId;
    _chatEnded = false;
    await setChatById();
  }

  Future<void> setChatById() async {
    if (id.isEmpty) {
      getChatBot = () => MyChatBot().chatBot();
    } else {
      Box chatHistoryBox = await Hive.openBox("chat_history");
      getChatBot = () => ChatBot.fromMessageHistoryMap(chatHistoryBox.get(id));
    }
  }

  ///Save chate and notify when the chat reached it's last state
  bool _chatEnded = false;
  bool get chatEnded => _chatEnded;
  Future<void> whatchChatEnded(ChatBot chatBot) async {
    chatBot.stateStream.listen((state) async {
      //if it is the last state
      if (state.id == "K" || state.id == "L") {
        //save chat
        Map<String, dynamic> chatHistory = await chatBot.getMessageHistoryMap();
        Box chatHistoryBox = await Hive.openBox("chat_history");
        await chatHistoryBox.put(chatBot.id, chatHistory);
        //notify that the chat ended
        _chatEnded = true;
        notifyListeners();
      }
    });
  }
}
