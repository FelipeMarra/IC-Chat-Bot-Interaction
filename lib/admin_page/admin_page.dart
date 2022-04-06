import 'package:chat_bot_interaction/chat_page/chat_page.dart';
import 'package:flutter/material.dart';
import '../chat_page/chat_page_controller.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({
    Key? key,
  }) : super(key: key);

  static const routeName = "/admin";

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late ChatPageController chatPageController;
  late List<Map<String, dynamic>> chats;
  bool initiated = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    chatPageController = context.read<ChatPageController>();
    chats = await chatPageController.getAllChats();
    setState(() {
      initiated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Chats"),
        centerTitle: true,
      ),
      body: initiated
          ? ListView.builder(
              shrinkWrap: true,
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: chats.length,
              itemBuilder: (contex, index) {
                String id = chats[index]["id"];
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
                        Navigator.of(context).pushNamed(ChatPage.routeName);
                      },
                    ),
                    const Divider(),
                  ],
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  String _getUserName(int index) {
    Map<String, dynamic> chatHistory = chats[index];
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
