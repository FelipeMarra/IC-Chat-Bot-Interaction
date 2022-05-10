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

Você está sendo convidado(a) a participar da pesquisa “Transformação Digital e a Propensão do Consumidor à Interação com Humanos Digitais”, desenvolvida pelos professores Paula Karina Salume, Marcelo de Rezende Pinto, Dárlinton Barbosa Feres Carvalho, com a colaboração dos bolsistas de iniciação científica Mariane Auxiliadora Fonseca e  Felipe Ferreira Marra. O objetivo central do estudo é analisar as atitudes do consumidor para a propensão de interagir com humanos digitais, a fim de fornecer informações variadas para as empresas e um avanço para os estudos dessa temática.
O convite a sua participação se deve ao interesse em encontrar resultados aplicáveis à indústria em geral, portanto estende-se o convite à população-alvo aberta de indivíduos de todo o Brasil, maiores de 18 anos. A sua participação é voluntária, isto é, ela não é obrigatória, possuindo plena autonomia para decidir se quer ou não participar, bem como retirar sua participação a qualquer momento. Não haverá penalização de nenhuma maneira caso decida não consentir sua participação, ou desistir da mesma. Contudo, ela é muito importante para a execução da pesquisa.

Serão garantidas a confidencialidade e a privacidade das informações prestadas, sendo toda a avaliação realizada de forma individual. Na presente pesquisa, você não será identificado pelo seu nome. Qualquer dado que possa identificá-lo será omitido na divulgação dos resultados da pesquisa, e o material será armazenado em local seguro. A qualquer momento, durante a pesquisa, ou posteriormente, você poderá solicitar do pesquisador informações sobre sua participação e/ou sobre a pesquisa, o que poderá ser feito através dos meios de contato explicitados neste documento.

A sua participação consistirá em interagir com um humano digital (chatbot) e, posteriormente, responder a algumas questões relacionadas à experiência vivenciada associada aos construtos abordados, atribuindo notas em uma escala de 1 a 7. A interação com o humano digital levará um tempo estimado de 3 minutos. O questionário a ser preenchido em seguida poderá levar, aproximadamente, 5 minutos. A qualquer momento será possível solicitar a interrupção da atividade. 

As respostas das questões serão armazenadas em arquivos digitais, assim como os resultados, mas somente terão acesso às mesmas os professores pesquisadores e os discentes colaboradores. Ao final da pesquisa, todo material será mantido em arquivo, por pelo menos 5 anos, conforme Resolução 466/12 e orientações do CEPSJ.

Como benefício da pesquisa teremos conhecimento sobre propensões dos consumidores em interagir com humanos digitais e assim alcançar descobertas vitais para o desenvolvimento e apoio aos negócios, além de uma possível orientação benéfica para o consumidor e um avanço acadêmico na busca do entendimento sobre o fenômeno dos humanos digitais no contexto brasileiro.

Os resultados gerais poderão ser divulgados em palestras dirigidas ao público participante, artigos científicos e eventos acadêmicos. Os resultados de forma individual só poderão ser repassados ao próprio participante, estando a equipe de pesquisadores à disposição para eventuais esclarecimentos.

Não haverá nenhum custo pela sua participação neste estudo. Este é um estudo financiado pela Universidade Federal de São João del Rei (UFSJ). 

Por favor, sinta-se à vontade para fazer qualquer pergunta sobre este estudo. Se outras perguntas surgirem posteriormente, você poderá entrar em contato com os pesquisadores por meio dos contatos disponibilizados.

Em caso de dúvida quanto à condução ética do estudo, entre em contato com o Comitê de Ética em Pesquisa da CEPSJ. O Comitê de Ética é a instância que tem por objetivo defender os interesses dos participantes da pesquisa em sua integridade e dignidade e para contribuir no desenvolvimento da pesquisa dentro de padrões éticos. Dessa forma, o comitê tem o papel de avaliar e monitorar o andamento do projeto de modo que a pesquisa respeite os princípios éticos de proteção aos direitos humanos, da dignidade, da autonomia, da não maleficência, da confidencialidade e da privacidade.
        """),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    """Comitê de Ética em Pesquisa Envolvendo Seres Humanos (CEPSJ)
E-mail:""",
              ),
              TextSpan(
                text: " cepsj@ufsj.edu.br ",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(
                text: """

Telefone: 32 3379-5598
Endereço: Praça Dom Helvécio, 74, Bairro Dom Bosco, São João del-Rei, Minas Gerais, CEP: 36301-160, Campus Dom Bosco
""",
              ),
            ],
          ),
        ),
        Text("Contato com os pesquisadores responsáveis:"),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: """

Dra. Paula Karina Salume
Professora do Departamento de Ciências Administrativas e Contábeis (DECAC)
Universidade Federal de São João del-Rei
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
Professor do Instituto de Ciências Econômicas e Gerenciais (ICEG)
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
                text: """Dr. Dárlinton Barbosa Feres Carvalho
Professor do Departamento de Ciência da Computação (DECOMP)
Universidade Federal de São João del-Rei
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
Bolsista de Iniciação Científica - Graduanda de Administração
Universidade Federal de São João del-Rei
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
Bolsista de Iniciação Científica - Graduando de Ciência da Computação
Universidade Federal de São João del-Rei
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
                    return "Campo Obrigatório";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Insira um e-mail válido";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
                "Abaixo assinale se compreendeu os objetivos e condições de sua participação na pesquisa e concorda em participar. *"),
            RadioFormWidget(
              onChange: (didAgree) {
                agreed = didAgree;
              },
            )
          ],
        ));
  }
}
