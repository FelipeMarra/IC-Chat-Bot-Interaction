import 'package:flutter/material.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MyChatBot {
  static const String botName = "Juliette";
  static String userName = "";
  static String smartPhoneModel = "IPhone 13";

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
        _stateE(),
        _stateF(),
        _stateG(),
        _stateH(),
        _stateHImage(),
        _stateI(),
        _stateJ(),
        _stateK(),
        _stateL()
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

  _stateA() {
    return BotStateOpenText(
      id: "A",
      messages: () => [
        const MarkdownBody(
          data: "Oi, tudo bem? Eu sou a $botName, e estou aqui para te ajudar!",
        ),
        const MarkdownBody(
          data:
              "Sabemos que o smartphone é um item praticamente indispensável nos dias atuais, não é mesmo?!  Com tantos modelos e marcas, eu sei que não é fácil escolher um e pensando nisso eu posso te ajudar a escolher qual está mais de acordo com as suas necessidades, mas antes preciso saber alguns detalhes.",
        ),
        const MarkdownBody(data: "Me conta, qual o seu nome?"),
      ],
      transitions: [
        BotTransition(id: "A=>ALoop", to: "ALoop"),
        BotTransition(id: "A=>B", to: "B"),
      ],
      decideTransition: _stateADecision,
    );
  }

  _stateALoop() {
    return BotStateOpenText(
      id: "ALoop",
      messages: () => [
        const MarkdownBody(
          data: "Eu realmente preciso saber seu nome...",
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

  BotStateOpenText _stateB() {
    return BotStateOpenText(
      id: "B",
      messages: () => [
        const MarkdownBody(
          data: "E qual o seu passatempo preferido, seu hobby?",
        ),
      ],
      transitions: [
        BotTransition(id: "B=>C", to: "C"),
      ],
      decideTransition: (controller) => "C",
    );
  }

  BotStateMultipleChoice _stateC() {
    return BotStateMultipleChoice(
      id: "C",
      messages: () => [
        MarkdownBody(
          data:
              "Legal $userName! Agora que sei um pouco sobre você podemos começar. Vamos lá?",
        ),
        const MarkdownBody(
          data: "Quais das categorias de apps a seguir você faz **maior** uso?",
        ),
      ],
      options: () => [
        BotOption(
          message: const MarkdownBody(data: "Jogos"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Redes Sociais"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Edição"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Produtividade"),
        ),
      ],
      transitions: [
        BotTransition(
          id: "C=>D",
          to: "D",
        ),
      ],
      decideTransition: (selection) => "D",
    );
  }

  BotStateMultipleChoice _stateD() {
    return BotStateMultipleChoice(
      id: "D",
      messages: () => [
        const MarkdownBody(
          data: "Quais das categorias de apps a seguir você faz **menor** uso?",
        ),
      ],
      options: () => [
        BotOption(
          message: const MarkdownBody(data: "Jogos"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Redes Sociais"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Edição"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Produtividade"),
        ),
      ],
      transitions: [
        BotTransition(
          id: "D=>E",
          to: "E",
        ),
      ],
      decideTransition: (selection) => "E",
    );
  }

  BotStateMultipleChoice _stateE() {
    return BotStateMultipleChoice(
        id: "E",
        messages: () => [
              const MarkdownBody(
                data:
                    "Entendi, agora preciso saber um pouco mais sobre o seu uso no geral. Em relação aos apps abaixo, quais você mais utiliza?",
              ),
              const MarkdownBody(
                data:
                    "Em relação à categoria de jogos, se você faz uso de algum desses apps, qual(is) você mais acessa?",
              ),
            ],
        options: () => [
              BotOption(
                message: const MarkdownBody(data: "Minecraft"),
              ),
              BotOption(
                message: const MarkdownBody(data: "Free Fire"),
              ),
              BotOption(
                message: const MarkdownBody(data: "Fortnite"),
              ),
              BotOption(
                message: const MarkdownBody(data: "Call of Duty"),
              ),
              BotOption(
                message: const MarkdownBody(data: "Geshin Impact"),
              ),
              BotOption(
                message: const MarkdownBody(
                  data: "League of Legends Wild Rift",
                ),
              ),
              BotOption(
                message: const MarkdownBody(data: "Asphalt 9"),
              ),
              BotOption(
                message: const MarkdownBody(data: "Candy Crush"),
              ),
              BotOption(
                message: const MarkdownBody(data: "PES 2021"),
              ),
              BotOption(
                message: const MarkdownBody(data: "Outros jogos"),
              ),
              BotOption(
                message: const MarkdownBody(data: "Nenhuma das opções acima"),
              ),
            ],
        transitions: [
          BotTransition(
            id: "E=>F",
            to: "F",
          ),
        ],
        decideTransition: (selection) => "F");
  }

  BotStateMultipleChoice _stateF() {
    return BotStateMultipleChoice(
      id: "F",
      messages: () => [
        const MarkdownBody(
          data:
              "Agora, sobre redes sociais, quais dos apps abaixo você faz uso mais frequente?",
        ),
      ],
      options: () => [
        BotOption(
          message: const MarkdownBody(data: "Instagram"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Facebook"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Whatsapp"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Tik Tok"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Youtube"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Snapchat"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Twitter"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Outras Redes Sociais"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Nenhuma das opções acima"),
        ),
      ],
      transitions: [
        BotTransition(
          id: "F=>G",
          to: "G",
        ),
      ],
      decideTransition: (selection) => "G",
    );
  }

  BotStateMultipleChoice _stateG() {
    return BotStateMultipleChoice(
      id: "G",
      messages: () => [
        const MarkdownBody(
          data:
              "Para fazer edição pelo smartphone, você faz uso de quais dos apps abaixo?",
        ),
      ],
      options: () => [
        BotOption(
          message: const MarkdownBody(data: "Tik Tok"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Photoshop"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Canva"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Vimeo"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Inshot"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Capcut"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Outros app de edição"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Nenhuma das opções acima"),
        ),
      ],
      transitions: [
        BotTransition(
          id: "G=>H",
          to: "H",
        ),
      ],
      decideTransition: (selection) => "H",
    );
  }

  BotStateMultipleChoice _stateH() {
    return BotStateMultipleChoice(
      id: "H",
      messages: () => [
        const MarkdownBody(
          data:
              "Interessante, agora só mais uma pergunta antes de eu te sugerir um modelo.",
        ),
        const MarkdownBody(
          data:
              "Em relação a produtividade, quais dos apps abaixo você utiliza mais?",
        ),
      ],
      options: () => [
        BotOption(
          message: const MarkdownBody(data: "Adobe Scam"),
        ),
        BotOption(
          message: const MarkdownBody(data: "CamScanner"),
        ),
        BotOption(
          message: const MarkdownBody(data: "PowerPoint"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Vimeo"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Google Docs"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Google Maps"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Outros app de produtividade"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Nenhuma das opções acima"),
        ),
      ],
      transitions: [
        BotTransition(
          id: "H=>I",
          to: "I",
        ),
      ],
      decideTransition: (selection) => "I",
    );
  }

  BotStateSingleChoice _stateI() {
    return BotStateSingleChoice(
      id: "I",
      messages: () => [
        const MarkdownBody(
          data: "Prontinho, finalizamos as perguntas, agora é comigo!",
        ),
        const MarkdownBody(
          data:
              "Com base nas suas respostas o smartphone que mais se adequa ao seu uso é",
        ),
      ],
      transitions: [
        BotTransition(id: "I=>IImage", to: "IImage"),
      ],
      onEnter: (machine) async {
        await Future.delayed(const Duration(seconds: 1));
        machine.transitionTo("IImage");
      },
    );
  }

  BotStateImage _stateHImage() {
    return BotStateImage(
      id: "IImage",
      image: () => Image.network(
        "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-pro-blue-select?wid=940&hei=1112&fmt=png-alpha&.v=1645552346275",
        fit: BoxFit.fill,
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
      label: () => [
        MarkdownBody(data: "**$smartPhoneModel**"),
      ],
      transition: BotTransition(id: "HImage=>I", to: "J"),
      onEnter: (machine) async {
        await Future.delayed(const Duration(seconds: 1));
        machine.transitionTo("J");
      },
    );
  }

  BotStateSingleChoice _stateJ() {
    return BotStateSingleChoice(
      id: "J",
      messages: () => [
        const MarkdownBody(data: "Adorei saber mais sobre você"),
        const MarkdownBody(
          data: "Mas me conta, eu consegui te ajudar com o que precisava?",
        ),
      ],
      options: [
        BotOption(
          message: const MarkdownBody(data: "Sim"),
        ),
        BotOption(
          message: const MarkdownBody(data: "Não"),
        ),
      ],
      transitions: [
        BotTransition(
          id: "J=>K",
          to: "K",
        ),
        BotTransition(
          id: "J=>L",
          to: "L",
        ),
      ],
      decideTransition: (option) => option.message.data == "Sim" ? "K" : "L",
    );
  }

  BotStateSingleChoice _stateK() {
    return BotStateSingleChoice(
      id: "K",
      messages: () => [
        const MarkdownBody(data: "Que bom!"),
        MarkdownBody(data: "Obrigado, e tenha um ótimo dia $userName!"),
      ],
    );
  }

  BotStateSingleChoice _stateL() {
    return BotStateSingleChoice(
      id: "L",
      messages: () => [
        const MarkdownBody(data: "Ahh que pena!"),
        MarkdownBody(data: "Obrigada, e tenha um ótimo dia $userName!"),
      ],
    );
  }
}
