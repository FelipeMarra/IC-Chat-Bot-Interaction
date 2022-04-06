import 'package:chat_bot_interaction/chat_page/my_chat_bot.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';

class ChatPageController extends ChangeNotifier {
  final fireRef = FirebaseDatabase.instance.ref();
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
      DataSnapshot snapshot = await fireRef.child(id).get();
      getChatBot = () =>
          ChatBot.fromMessageHistoryMap(snapshot.value as Map<String, dynamic>);
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
        //TODO se n tiver o future ele n salva o ultimo estado
        await Future.delayed(const Duration(seconds: 2));
        if (chatBot.historyMode == false) {
          await _storeChat(chatBot);
        }
        //notify that the chat ended
        _chatEnded = true;
        notifyListeners();
      }
    });
  }

  _storeChat(chatBot) async {
    final Map chatHistoryMap = await chatBot.getMessageHistoryMap();
    await fireRef.child(chatHistoryMap["id"]).set(chatHistoryMap);
  }

  Future<List<Map<String, dynamic>>> getAllChats() async {
    DatabaseEvent historyEvent = await fireRef.once();
    Map historyMap = historyEvent.snapshot.value as Map;
    List<Map<String, dynamic>> historyList = [];
    historyMap.forEach((key, value) {
      historyList.add(value);
    });

    return historyList;
  }
}
