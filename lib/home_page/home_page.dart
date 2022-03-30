import 'package:chat_bot_interaction/chat_page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../chat_page/chat_page_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box chatHistoryBox;
  bool initiated = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    chatHistoryBox = await Hive.openBox("chat_history");
    setState(() {
      initiated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ChatPageController chatPageController =
        context.watch<ChatPageController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Chats"),
        centerTitle: true,
      ),
      body: initiated && chatHistoryBox.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: chatHistoryBox.length,
              itemBuilder: (contex, index) {
                String id = chatHistoryBox.getAt(index)["id"];
                DateTime date = DateTime.fromMillisecondsSinceEpoch(
                  int.parse(id),
                );
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Chat id: $id",
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Nome do Usuário: ${_getUserName(index)}",
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Criado em ${_formatDateNum(date.day)}/${_formatDateNum(date.month)} às ${_formatDateNum(date.hour)}:${_formatDateNum(date.minute)}",
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      onTap: () async {
                        await chatPageController.start(id);
                        Navigator.of(context)
                            .popAndPushNamed(ChatPage.routeName);
                      },
                    ),
                    const Divider(),
                  ],
                );
              },
            )
          : Container(),
      floatingActionButton: Tooltip(
        message: "Criar novo chat",
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await chatPageController.start("");
            Navigator.popAndPushNamed(context, ChatPage.routeName);
          },
        ),
      ),
    );
  }

  String _getUserName(int index) {
    Map<String, dynamic> chatHistory = chatHistoryBox.getAt(index);
    Map<String, dynamic>? last;

    chatHistory.forEach((key, value) {
      if (key != "id") {
        if (value["id"] == "A" || value["id"] == "ALoop") {
          last = value;
        }
        if (value["id"] == "B") {
          return;
        }
      }
    });

    return last!["userMessages"][0] ?? "";
  }

  String _formatDateNum(int number) {
    return number < 10 ? "0$number" : number.toString();
  }
}
