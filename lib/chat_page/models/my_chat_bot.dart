import 'package:chat_bot_interaction/chat_page/models/pts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_composer/flutter_chat_composer.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MyChatBot {
  static const String botName = "Juliette";
  static String userName = "";
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  List<String> jumpIds = [];
  PtsModel ptsModel = PtsModel();

  ChatBot chatBot() {
    return ChatBot(
      id: id,
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

  String _stateADecision(String textController) {
    if (textController.isEmpty) {
      return "ALoop";
    } else {
      userName = textController;
      return "B";
    }
  }

  BotStateOpenText _stateA() {
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

  BotStateOpenText _stateALoop() {
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
        if (textController.isEmpty) {
          return "ALoop";
        } else {
          userName = textController;
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
          data:
              "Qual(is) das categorias de apps a seguir você faz **maior** uso?",
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
      decideTransition: (selection) {
        for (var element in selection) {
          if (element.message.data == "Jogos") {
            ptsModel.sumGames(1);
          } else if (element.message.data == "Redes Sociais") {
            ptsModel.sumSocialNetwork(1);
          } else if (element.message.data == "Edição") {
            ptsModel.sumEditing(1);
          } else if (element.message.data == "Produtividade") {
            ptsModel.sumProductivity(1);
          }
        }
        return "D";
      },
    );
  }

  BotStateMultipleChoice _stateD() {
    return BotStateMultipleChoice(
      id: "D",
      messages: () => [
        const MarkdownBody(
          data:
              "Qual(is) das categorias de apps a seguir você faz **menor** uso?",
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
        BotTransition(
          id: "D=>F",
          to: "F",
        ),
        BotTransition(
          id: "D=>G",
          to: "G",
        ),
        BotTransition(
          id: "D=>H",
          to: "H",
        ),
        BotTransition(
          id: "D=>I",
          to: "I",
        ),
      ],
      decideTransition: (selection) {
        for (BotOption option in selection) {
          switch (option.message.data) {
            case "Jogos":
              jumpIds.add("E");
              ptsModel.sumGames(-1);
              break;
            case "Redes Sociais":
              ptsModel.sumSocialNetwork(-1);
              jumpIds.add("F");
              break;
            case "Edição":
              ptsModel.sumEditing(-1);
              jumpIds.add("G");
              break;
            case "Produtividade":
              ptsModel.sumProductivity(-1);
              jumpIds.add("H");
              break;
            default:
          }
        }
        if (!jumpIds.contains("E")) {
          return "E";
        }
        if (!jumpIds.contains("F")) {
          return "F";
        }
        if (!jumpIds.contains("G")) {
          return "G";
        }
        if (!jumpIds.contains("H")) {
          return "H";
        }
        return "I";
      },
    );
  }

  BotStateMultipleChoice _stateE() {
    return BotStateMultipleChoice(
      id: "E",
      messages: () => [
        const MarkdownBody(
          data:
              "Entendi, agora preciso saber um pouco mais sobre o seu uso no geral. Em relação aos apps abaixo, qual(is) você mais utiliza?",
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
        BotTransition(
          id: "E=>G",
          to: "G",
        ),
        BotTransition(
          id: "E=>H",
          to: "H",
        ),
        BotTransition(
          id: "E=>I",
          to: "I",
        ),
      ],
      decideTransition: (selection) {
        ptsModel.sumGames(selection.length);

        if (!jumpIds.contains("F")) {
          return "F";
        }
        if (!jumpIds.contains("G")) {
          return "G";
        }
        if (!jumpIds.contains("H")) {
          return "H";
        }
        return "I";
      },
    );
  }

  BotStateMultipleChoice _stateF() {
    return BotStateMultipleChoice(
      id: "F",
      messages: () => [
        const MarkdownBody(
          data:
              "Agora, sobre redes sociais, qual(is) dos apps abaixo você faz uso mais frequente?",
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
        BotTransition(
          id: "F=>H",
          to: "H",
        ),
        BotTransition(
          id: "F=>I",
          to: "I",
        ),
      ],
      decideTransition: (selection) {
        ptsModel.sumSocialNetwork(selection.length);

        if (!jumpIds.contains("G")) {
          return "G";
        }
        if (!jumpIds.contains("H")) {
          return "H";
        }
        return "I";
      },
    );
  }

  BotStateMultipleChoice _stateG() {
    return BotStateMultipleChoice(
      id: "G",
      messages: () => [
        const MarkdownBody(
          data:
              "Para fazer edição pelo smartphone, você faz uso de qual(is) dos apps abaixo?",
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
        BotTransition(
          id: "G=>I",
          to: "I",
        ),
      ],
      decideTransition: (selection) {
        ptsModel.sumEditing(selection.length);

        if (!jumpIds.contains("H")) {
          return "H";
        }
        return "I";
      },
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
              "Em relação a produtividade, qual(is) dos apps abaixo você utiliza mais?",
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
      decideTransition: (selection) {
        ptsModel.sumProductivity(selection.length);

        return "I";
      },
    );
  }

  BotStateSingleChoice _stateI() {
    return BotStateSingleChoice(
      id: "I",
      messages: () => [
        const MarkdownBody(
          data: "Prontinho, finalizamos as perguntas, agora é comigo!",
        ),
        MarkdownBody(
          data:
              "Com base nas suas respostas você faz muito uso de apps de ${ptsModel.result.category}, portanto o smartphone que mais se adequa ao seu uso é ",
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
        ptsModel.result.image,
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
        MarkdownBody(data: "**${ptsModel.result.smartphone}**"),
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
      options: () => [
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
