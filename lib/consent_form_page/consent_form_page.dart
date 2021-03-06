import 'package:chat_bot_interaction/chat_page/chat_page.dart';
import 'package:chat_bot_interaction/chat_page/chat_page_controller.dart';
import 'package:chat_bot_interaction/consent_form_page/radio_form_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsentFormPage extends StatefulWidget {
  static const String routeName = "/";

  const ConsentFormPage({Key? key}) : super(key: key);

  @override
  State<ConsentFormPage> createState() => _ConsentFormPageState();
}

class _ConsentFormPageState extends State<ConsentFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  bool agreed = true;

  @override
  Widget build(BuildContext context) {
    final ChatPageController chatPageController =
        context.read<ChatPageController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _termText(),
              _consentimentForm(),
              Center(
                  child: TextButton(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Text(
                        "Continuar",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true && agreed) {
                    chatPageController.userEmail = _textController.value.text;
                    await chatPageController.start("");
                    Navigator.of(context).popAndPushNamed(ChatPage.routeName);
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Column _termText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text(
          "Termo de Consentimento Livre e Esclarecido",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text("""

Prezado(a) participante, 

Voc?? est?? sendo convidado(a) a participar da pesquisa ???Transforma????o Digital e a Propens??o do Consumidor ?? Intera????o com Humanos Digitais???, desenvolvida pelos professores Paula Karina Salume, Marcelo de Rezende Pinto, D??rlinton Barbosa Feres Carvalho, com a colabora????o dos bolsistas de inicia????o cient??fica Mariane Auxiliadora Fonseca e  Felipe Ferreira Marra. O objetivo central do estudo ?? analisar as atitudes do consumidor para a propens??o de interagir com humanos digitais, a fim de fornecer informa????es variadas para as empresas e um avan??o para os estudos dessa tem??tica.
O convite a sua participa????o se deve ao interesse em encontrar resultados aplic??veis ?? ind??stria em geral, portanto estende-se o convite ?? popula????o-alvo aberta de indiv??duos de todo o Brasil, maiores de 18 anos. A sua participa????o ?? volunt??ria, isto ??, ela n??o ?? obrigat??ria, possuindo plena autonomia para decidir se quer ou n??o participar, bem como retirar sua participa????o a qualquer momento. N??o haver?? penaliza????o de nenhuma maneira caso decida n??o consentir sua participa????o, ou desistir da mesma. Contudo, ela ?? muito importante para a execu????o da pesquisa.

Ser??o garantidas a confidencialidade e a privacidade das informa????es prestadas, sendo toda a avalia????o realizada de forma individual. Na presente pesquisa, voc?? n??o ser?? identificado pelo seu nome. Qualquer dado que possa identific??-lo ser?? omitido na divulga????o dos resultados da pesquisa, e o material ser?? armazenado em local seguro. A qualquer momento, durante a pesquisa, ou posteriormente, voc?? poder?? solicitar do pesquisador informa????es sobre sua participa????o e/ou sobre a pesquisa, o que poder?? ser feito atrav??s dos meios de contato explicitados neste documento.

A sua participa????o consistir?? em interagir com um humano digital (chatbot) e, posteriormente, responder a algumas quest??es relacionadas ?? experi??ncia vivenciada associada aos construtos abordados, atribuindo notas em uma escala de 1 a 7. A intera????o com o humano digital levar?? um tempo estimado de 3 minutos. O question??rio a ser preenchido em seguida poder?? levar, aproximadamente, 5 minutos. A qualquer momento ser?? poss??vel solicitar a interrup????o da atividade. 

As respostas das quest??es ser??o armazenadas em arquivos digitais, assim como os resultados, mas somente ter??o acesso ??s mesmas os professores pesquisadores e os discentes colaboradores. Ao final da pesquisa, todo material ser?? mantido em arquivo, por pelo menos 5 anos, conforme Resolu????o 466/12 e orienta????es do CEPSJ.

Como benef??cio da pesquisa teremos conhecimento sobre propens??es dos consumidores em interagir com humanos digitais e assim alcan??ar descobertas vitais para o desenvolvimento e apoio aos neg??cios, al??m de uma poss??vel orienta????o ben??fica para o consumidor e um avan??o acad??mico na busca do entendimento sobre o fen??meno dos humanos digitais no contexto brasileiro.

Os resultados gerais poder??o ser divulgados em palestras dirigidas ao p??blico participante, artigos cient??ficos e eventos acad??micos. Os resultados de forma individual s?? poder??o ser repassados ao pr??prio participante, estando a equipe de pesquisadores ?? disposi????o para eventuais esclarecimentos.

N??o haver?? nenhum custo pela sua participa????o neste estudo. Este ?? um estudo financiado pela Universidade Federal de S??o Jo??o del Rei (UFSJ). 

Por favor, sinta-se ?? vontade para fazer qualquer pergunta sobre este estudo. Se outras perguntas surgirem posteriormente, voc?? poder?? entrar em contato com os pesquisadores por meio dos contatos disponibilizados.

Em caso de d??vida quanto ?? condu????o ??tica do estudo, entre em contato com o Comit?? de ??tica em Pesquisa da CEPSJ. O Comit?? de ??tica ?? a inst??ncia que tem por objetivo defender os interesses dos participantes da pesquisa em sua integridade e dignidade e para contribuir no desenvolvimento da pesquisa dentro de padr??es ??ticos. Dessa forma, o comit?? tem o papel de avaliar e monitorar o andamento do projeto de modo que a pesquisa respeite os princ??pios ??ticos de prote????o aos direitos humanos, da dignidade, da autonomia, da n??o malefic??ncia, da confidencialidade e da privacidade.
        """),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    """Comit?? de ??tica em Pesquisa Envolvendo Seres Humanos (CEPSJ)
E-mail:""",
              ),
              TextSpan(
                text: " cepsj@ufsj.edu.br ",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(
                text: """

Telefone: 32 3379-5598
Endere??o: Pra??a Dom Helv??cio, 74, Bairro Dom Bosco, S??o Jo??o del-Rei, Minas Gerais, CEP: 36301-160, Campus Dom Bosco
""",
              ),
            ],
          ),
        ),
        Text("Contato com os pesquisadores respons??veis:"),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: """

Dra. Paula Karina Salume
Professora do Departamento de Ci??ncias Administrativas e Cont??beis (DECAC)
Universidade Federal de S??o Jo??o del-Rei
E-mail:""",
              ),
              TextSpan(
                text: """  paulasalume@ufsj.edu.br""",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(
                text: """

Telefone: +55 31 99982-1688
""",
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: """Dr. Marcelo de Rezende Pinto
Professor do Instituto de Ci??ncias Econ??micas e Gerenciais (ICEG)
PUC Minas
E-mail:""",
              ),
              TextSpan(
                text: """ marcrez@hotmail.com""",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(
                text: """

Telefone: +5531 99967-0518
""",
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: """Dr. D??rlinton Barbosa Feres Carvalho
Professor do Departamento de Ci??ncia da Computa????o (DECOMP)
Universidade Federal de S??o Jo??o del-Rei
E-mail:""",
              ),
              TextSpan(
                text: """ darlinton@ufsj.edu.br""",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(
                text: """

Telefone: +55 32 99199-2566
""",
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: """Mariane Auxiliadora Fonseca  
Bolsista de Inicia????o Cient??fica - Graduanda de Administra????o
Universidade Federal de S??o Jo??o del-Rei
E-mail:""",
              ),
              TextSpan(
                text: """ fonseccamariane@outlook.com""",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(
                text: """

Telefone: +55 32 99832-7729
""",
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: """Felipe Ferreira Marra
Bolsista de Inicia????o Cient??fica - Graduando de Ci??ncia da Computa????o
Universidade Federal de S??o Jo??o del-Rei
E-mail:""",
              ),
              TextSpan(
                text: """ felipeferreiramarra@gmail.com""",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(
                text: """

Telefone: +55  37 99947-6397
""",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Form _consentimentForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8.0,
            ),
            const Text("E-mail *"),
            Padding(
              padding: const EdgeInsets.only(right: 200.0),
              child: TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  label: Text("Seu e-mail"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigat??rio";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Insira um e-mail v??lido";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
                "Abaixo assinale se compreendeu os objetivos e condi????es de sua participa????o na pesquisa e concorda em participar. *"),
            RadioFormWidget(
              onChange: (didAgree) {
                agreed = didAgree;
              },
            )
          ],
        ));
  }
}
