import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';

class MyChatBot {
  static const String botName = "Juliette";
  static String userName = "";

  ChatBot chatBot() {
    return ChatBot(
      id: "chat_bot",
      initialStateId: "A",
      states: [
        _stateA(),
        _stateALoop(),
        _stateB(),
        _stateC(),
        _stateD(),
      ],
    );
  }

  String _stateADecision(TextEditingController textController) {
    if (textController.text.isEmpty) {
      return "ALoop";
    } else {
      userName = textController.text;
      return "B";
    }
  }

  BotStateOpenText _stateA() {
    return BotStateOpenText(
      id: "A",
      messages: () => [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: "Oi, eu sou a "),
              TextSpan(
                text: botName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        RichText(
          text: const TextSpan(children: [
            TextSpan(text: "Eu posso te ajudar com a escolha do "),
            TextSpan(
              text: "seu próximo smartphone",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ", mas antes preciso saber alguns detalhes...")
          ]),
        ),
        RichText(text: const TextSpan(text: "Me conta, qual seu nome?")),
      ],
      transitions: [
        BotTransition(id: "A=>ALoop", to: "ALoop"),
        BotTransition(id: "A=>B", to: "B"),
      ],
      decideTransition: _stateADecision,
    );
  }

  BotStateOpenText _stateALoop() {
    return BotStateOpenText(
      id: "ALoop",
      messages: () => [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: "Eu realmente preciso saber seu nome... "),
            ],
          ),
        ),
      ],
      transitions: [
        BotTransition(id: "ALoop=>ALoop", to: "ALoop"),
        BotTransition(id: "ALoop=>B", to: "B"),
      ],
      decideTransition: (textController) {
        if (textController.text.isEmpty) {
          return "ALoop";
        } else {
          userName = textController.text;
          return "B";
        }
      },
    );
  }

  BotState _stateB() {
    return BotState(
      id: "B",
      messages: () => [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text:
                      "Legal $userName! Agora que sei um pouco sobre você podemos começar. Vamos la? "),
            ],
          ),
        ),
        RichText(
          text: const TextSpan(children: [
            TextSpan(text: "Qual das categorias de apps a seguir você faz "),
            TextSpan(
              text: "maior ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: "uso?"),
          ]),
        ),
      ],
      transitions: [
        BotTransition(
          id: "B=>C1",
          to: "C",
          message: RichText(
            text: const TextSpan(text: "Jogos"),
          ),
        ),
        BotTransition(
          id: "B=>C2",
          to: "C",
          message: RichText(
            text: const TextSpan(text: "Redes Sociais"),
          ),
        ),
        BotTransition(
          id: "B=>C3",
          to: "C",
          message: RichText(
            text: const TextSpan(text: "Edição"),
          ),
        ),
        BotTransition(
          id: "B=>C4",
          to: "C",
          message: RichText(
            text: const TextSpan(text: "Produtividade"),
          ),
        ),
      ],
    );
  }

  BotState _stateC() {
    return BotState(
      id: "C",
      messages: () => [
        RichText(
          text: const TextSpan(children: [
            TextSpan(text: "Qual das categorias de apps a seguir você faz "),
            TextSpan(
              text: "menor ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: "uso?"),
          ]),
        ),
      ],
      transitions: [
        BotTransition(
          id: "C=>D1",
          to: "D",
          message: RichText(
            text: const TextSpan(text: "Jogos"),
          ),
        ),
        BotTransition(
          id: "C=>D2",
          to: "D",
          message: RichText(
            text: const TextSpan(text: "Redes Sociais"),
          ),
        ),
        BotTransition(
          id: "C=>D3",
          to: "D",
          message: RichText(
            text: const TextSpan(text: "Edição"),
          ),
        ),
        BotTransition(
          id: "C=>D4",
          to: "D",
          message: RichText(
            text: const TextSpan(text: "Produtividade"),
          ),
        ),
      ],
    );
  }

  BotState _stateD() {
    return BotState(
      id: "D",
      messages: () => [
        RichText(
          text: const TextSpan(children: [
            TextSpan(
                text:
                    "Legal, agora quero saber um pouco mais sobre seu uso no geral. "),
            TextSpan(
                text: "Em relação aos apps abaixo, quais você mais utiliza?"),
          ]),
        ),
      ],
      transitions: [
        BotTransition(
          id: "D=>E1",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Minecraft"),
          ),
        ),
        BotTransition(
          id: "D=>E2",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Free Fire"),
          ),
        ),
        BotTransition(
          id: "D=>E3",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Call of Duty"),
          ),
        ),
        BotTransition(
          id: "D=>E4",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Fortinite"),
          ),
        ),
        BotTransition(
          id: "D=>E5",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Geshin Impact"),
          ),
        ),
        BotTransition(
          id: "D=>E6",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "League of Legends Wild Rift"),
          ),
        ),
        BotTransition(
          id: "D=>E7",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Asphalt 9"),
          ),
        ),
        BotTransition(
          id: "D=>E8",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Candy Crush"),
          ),
        ),
        BotTransition(
          id: "D=>E9",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "PES 2021"),
          ),
        ),
        BotTransition(
          id: "D=>E10",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Outros jogos"),
          ),
        ),
        BotTransition(
          id: "D=>E11",
          to: "E",
          message: RichText(
            text: const TextSpan(text: "Nenhuma das opções acima"),
          ),
        ),
      ],
    );
  }
}
