import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'FirebaseDocuments.dart';
import 'Navegador.dart';
import 'SizeConfig.dart';
import 'TrashColors.dart';
import 'package:toast/toast.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  bool checkbox = false;

  void _onIntroEnd(context) {
    if (checkbox == true) {
      FirebaseDocuments().primeiroLogin();
      Navegador().goToHome(context);
    } else {
      Toast.show("Concorde com os termos antes de prosseguir", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    String data = '''Última atualização: 17 de julho de 2020.\n\n

É de suma importância que você leia atentamente a presente POLÍTICA DE PRIVACIDADE (“Política”) antes de utilizar os serviços da TRASH2MONEY.\n\n
A TRASH2MONEY tem como princípio a preservação e a proteção da sua privacidade e seus dados. Por meio desta Política de Privacidade, nós asseguramos esse compromisso.\n\n
Ao utilizar os nossos serviços, você está de acordo e ciente acerca da presente Política de Privacidade. Lembrando que você pode acessá-la no momento em que desejar, mas é essencial que você a leia antes de qualquer coisa.\n\n

Esta Política de Privacidade pode sofrer alterações com o tempo. Sempre que ela for alterada, será indicado, no texto, a data da última modificação. Além disso, você também receberá um e-mail comunicando quais foram as alterações realizadas, com o link para acesso ao texto completo.\n\n

Caso você tenha alguma dúvida em relação a esta Política de Privacidade, entre em contato conosco através do e-mail  contato@trash2money.com.\n\n

Importante dizer que essa Política de Privacidade e os serviços prestados pela TRASH2MONEY estão de acordo com a Lei Geral de Proteção de Dados (Lei nº 13.709/2018). Assim como esta Lei brasileira, a TRASH2MONEY também quer garantir os direitos das pessoas em relação a seus dados pessoais.\n\n

Antes de adentramos a política em si, vamos fornecer um glossário de alguns dos mais importantes termos utilizados nesta Política de Privacidade:\n\n

COLETOR: é a pessoa que vai até a residência coletar o resíduo e dar a destinação correta; é quem paga para o RECICLADOR um valor estipulado semanalmente referente ao resíduo que será coletado;\n
RECICLADOR: é a pessoa que separa os resíduos e recebe o pagamento para que um COLETOR vá buscá-lo em sua residência;\n
COLETA: é o ato do COLETOR de ir buscar um material junto com uma RECICLADOR; após a coleta este material receberá a devida destinação e, assim, será reutilizado de alguma maneira;\n
RESÍDUO: é o material que fora separado pelo RECICLADOR e será vendido para os COLETORES e, assim, reutilizado de alguma maneira, após o processo de coleta.\n
CEMPRE: é o Compromisso Empresarial para Reciclagem, o qual possui uma cotação cujos valores que será utilizada como base para as transações realizadas na TRASH2MONEY.\n\n


Então, vamos ao que interessa!\n\n

Os seus dados são coletados, armazenados e utilizados pela TRASH2MONEY  com o intuito de proporcionar o melhor serviço para você.\n\n

Assim, nós explicamos, de forma simples e direta:\n\n

Quais são os dados coletados;\n
Por que os dados são coletados e para que são utilizados;\n
Para quem e por que os seus dados são compartilhados; e\n
Como os seus dados são armazenados e protegidos.\n\n

Coletar um dado nada mais é do que conseguir ter acesso a uma informação pessoal fornecida por você. Essa informação permite com que você seja identificado(a) por nós.\n\n

Nós temos acesso às informações das pessoas através do nosso formulário de cadastro.\n\n

Para se tornar um RECICLADOR ou RECICLADORA na plataforma TRASH2MONEY, os seguintes dados serão coletados:\n\n

nome;\n
e-mail;\n
endereço;\n
telefone;\n

Importante dizer que, quando formos solicitar essas informações, sempre vamos perguntar se você consente em fornecê-las e nós também vamos indicar, no momento da coleta, para qual finalidade esta informação será usada, de maneira bem clara e destacada.\n\n

Para além disso, no momento em que você utiliza nossos serviços, nós poderemos coletar automaticamente dados sobre os dispositivos que você utiliza, como endereços de IP, navegador que está sendo utilizado, os cliques realizados na nossa página, o idioma de uso, modelo, operadora e dados sobre as redes de Wi-Fi, dentre outros.\n\n

Esses dados são coletados através das ferramentas do Google Analytics e do Firebase Analytics. É válido mencionar que esses dados passam por um processo de anonimização, ou seja, não é possível identificar qual o indivíduo que é detentor desses dados. É importante dizermos que os processos de anonimização de dados são considerados pela LGPD como práticas de segurança em relação aos dados pessoais.\n\n

Nesse sentido, o COLETOR selecionará o resíduo que deseja coletar e um  RECICLADOR, dentre as opções disponíveis.\n\n

Devidamente realizado o pagamento através da plataforma, o COLETOR é autorizado e notificado pela TRASH2MONEY a realizar a coleta. É neste momento que os dados referentes ao endereço do RECICLADOR são disponibilizados para o COLETOR. Antes da realização do pagamento, esses dados pessoais ficam ocultos.\n\n

Ao se cadastrar no site TRASH2MONEY, cada usuário recebe uma identificação única, que passa a ser requerida e autenticada nos demais acessos ao site. Essa identificação, para os fins de direito, serve como assinatura e habilitação pelas ações do usuário no site.\n\n

A identificação dos usuários é exclusiva e intransferível para ser transmitida ao servidor da TRASH2MONEY.\n\n

A TRASH2MONEY não tem acesso às informações de senha e login.\n\n

Para além disso, a TRASH2MONEY se utiliza de sistema de token para a recuperação de senha, troca de e-mail e para a autenticação. A autenticação é realizada pelo FirebaseAuth.\n\n

Fica desde já alertado que a TRASH2MONEY nunca enviará e-mail ou solicitará por telefone confirmação ou complementação de dados cadastrais e/ou financeiros do usuário. Qualquer e-mail ou telefonema nesse sentido deverá ser entendido como fora dos padrões da TRASH2MONEY e consequentemente denunciado ao site pelo usuário.\n\n

Vale ressaltar que a TRASH2MONEY, quando viabiliza a imagem dos COLETORES e RECICLADORES não tem como objetivo incitar condutas discriminatórias, racistas, misóginas, nem tampouco realiza qualquer tratamento discriminatório.\n\n

O site da TRASH2MONEY identifica e armazena informações relativas aos visitantes através de Cookies, com o intuito de facilitar e melhorar a experiência de aquisição dos serviços.\n\n

Você tem total liberdade para optar por desabilitar os Cookies. Para isso, basta desativar a opção de salvamento e leitura de dados por Cookies, presente nas configurações do navegador utilizado. É possível também impedir os Cookies pelo sistema de Antivírus, caso você tenha instalado em seu computador ou celular.\n\n

Os links externos presentes em nossas páginas que direcionam para outros sites, plataformas ou redes sociais (como Facebook, Google, LinkedIn) não estão assegurados pela presente Política de Privacidade. Os endereços destes links podem coletar informações distintas sobre você para outros fins e de outras formas que diferem da nossa política, por isso, verifique com atenção as Políticas de Privacidade e Termos de Uso destes endereços\n\n

Quando você desejar, poderá solicitar quais os seus dados pessoais que a TRASH2MONEY possui.\n\n

Você também pode corrigir algum dado, alterá-lo ou atualizá-lo e tem o direito de solicitar que os seus dados sejam excluídos a qualquer tempo, desde que não utilize ou não queira mais utilizar a plataforma da TRASH2MONEY.\n\n

Para além disso, você também pode entrar em contato conosco para obter informações acerca do tratamento dos seus dados. Nós vamos disponibilizar essas informações de maneira gratuita e clara.\n\n

Para ter qualquer informação sobre seus dados, basta entrar em contato conosco através do email contato@trash2money.com .\n\n

É através deste mesmo e-mail que você pode solicitar a portabilidade dos dados e revogar o seu consentimento.\n\n

Os dados coletados pela TRASH2MONEY ficam armazenados na plataforma pelo prazo de 2 (dois) anos após à inativação do usuário ou enquanto os usuários estiverem ativos na plataforma.\n\n

Trata-se do prazo necessário para que esse dado seja tratado, na forma do art. 15 da LGPD, e que as finalidades do tratamento sejam concretizadas, principalmente no que se refere ao envio de propagandas que sejam assertiva e efetivas, bem como para que consigamos comunicar e notificar com continuidade e periodicidade os serviços que estão sendo prestados aos nossos clientes.\n\n

Caso tenhamos algum incidente ou acidente que envolva os dados (vazamento de dados, invasão da plataforma, etc..), temos um procedimento de atuação que consiste em: i) no envio de uma notificação a todas as pessoas - Profissionais e clientes - que chegaram a nos fornecer dados através do cadastro na plataforma, de modo a alertar acerca do incidente e de possíveis contatos e abordagens realizados em nome da TRASH2MONEY e, ii) para além disso, apagaremos todas as fotografias enviadas e registradas em nossa plataforma, de modo a mitigar danos e exposições.\n\n

Em determinadas hipóteses, a TRASH2MONEY poderá compartilhar os seus dados com terceiros. Vamos explicar, abaixo, para quem os seus dados são compartilhados e por qual motivo.\n\n

Outros usuários\n\n

Os usuários terão acesso à algumas informações uns dos outros. Isso é necessário pois a TRASH2MONEY é um serviço que se baseia na relação entre os seus usuários, ou seja, RECICLADOR e COLETOR.\n\n

Outros serviços\n\n

No caso da TRASH2MONEY se utilizar de serviços de terceiros para melhoria da prestação do seu serviço, bem como análise de dados, manutenção da plataforma e pagamentos, os seus dados poderão ser compartilhados.\n\n

Isso acontece porque a TRASH2MONEY, assim como as demais empresas de tecnologia, se utilizam de serviços de terceiros para ajudar em diversas áreas do seu negócio.\n\n

Entretanto, o compartilhamento dos dados será somente o estritamente necessário para a execução da atividade solicitada.\n\n

Outras empresas\n\n

Caso a TRASH2MONEY participe de uma reorganização societária, como uma fusão, cisão, incorporação, os seus dados podem ser transferidos.\n\n

Esse tipo de operação ocorre quando uma empresa é vendida a outra, incorporada e assim por diante. Por isso, é necessária a transferência de tais dados.\n\n

Judicial\n\n

A TRASH2MONEY poderá compartilhar os seus dados para autoridades, como a polícia ou o Poder Judiciário, no caso de ser solicitada judicialmente ou por requerimento das mesmas, com base na legislação aplicável.\n\n

Isso é necessário para que a TRASH2MONEY esteja dentro da legalidade, além de fazer parte da nossa política a cooperação com as autoridades sempre que se entenda necessário para investigações que possam prejudicar a TRASH2MONEY e/ou seus usuários.\n\n

Importante ressaltar que quando este compartilhamento ocorrer entre os usuários da plataforma, será notificado através do aplicativo, de modo que ele consinta com o compartilhamento desses dados e entenda qual o motivo do mesmo, de maneira clara e destacada. De maneira prática, esse consentimento será solicitado quando do cadastro na plataforma.\n\n

O consentimento é condição exigida pela Lei Geral de Proteção de dados (art.7º, §5º da LGPD) para que possa haver o compartilhamento de dados.\n\n

Assim, nenhuma informação individual será fornecida a terceiros sem sua prévia autorização, exceto por força de cumprimento de determinação judicial.\n\n

Os seus dados são armazenados em serviços de nuvem contratados pela TRASH2MONEY, que são comumente utilizados por empresas de tecnologia. No caso, a TRASH2MONEY se utiliza do Google Firebase.\n\n

Esses serviços de nuvem não necessariamente estão localizados no Brasil.\n\n

Os seus dados são confidenciais e só serão vistos por aqueles que possuem a devida autorização e motivação para tal.\n\n

A TRASH2MONEY sempre se esforçará para proteger os seus dados de quaisquer ameaças, como o roubo ou a utilização indevida. Para isso, utilizaremos as melhores práticas do mercado para garantir a segurança, como a anonimização dos seus dados, sempre que possível, além de monitorar e realizar testes de segurança.\n\n

A TRASH2MONEY sempre irá agir no sentido de garantir que a segurança dos seus dados, para que estes não sejam alvo de violações, mesmo com os avanços constantes de diferentes técnicas de roubo de dados. Além disso, você deverá sempre manter a sua senha em local seguro e protegida, para evitar a utilização por terceiros não desejados.\n\n

Caso você verifique que a sua conta foi utilizada por terceiros, você deverá notificar imediatamente a TRASH2MONEY, para que sejam tomadas as atitudes cabíveis.\n\n

A TRASH2MONEY tem o objetivo de estabelecer uma relação de confiança com o titular dos dados, através de uma atuação transparente que visa assegurar os mecanismos de participação do titular.\n\n
Assim, é importante mencionar que você, titular dos dados, tem seus direitos garantidos pela TRASH2MONEY, como previsto na Lei Geral de Proteção de Dados, como por exemplo:\n\n

I - confirmação da existência de tratamento;\n
II - acesso aos dados;\n
III - correção de dados incompletos, inexatos ou desatualizados;\n
IV - anonimização, bloqueio ou eliminação de dados desnecessários, excessivos ou tratados em desconformidade com o disposto nesta Lei;\n
V - portabilidade dos dados a outro fornecedor de serviço ou produto, mediante requisição expressa, de acordo com a regulamentação da autoridade nacional, observados os segredos comercial e industrial;\n
VI - eliminação dos dados pessoais tratados com o consentimento do titular, exceto nas hipóteses previstas no art. 16 desta Lei;\n
VII - informação das entidades públicas e privadas com as quais o controlador realizou uso compartilhado de dados;\n
VIII - informação sobre a possibilidade de não fornecer consentimento e sobre as consequências da negativa;\n
IX - revogação do consentimento.\n\n''';

    const bodyStyle = TextStyle(fontSize: 18, color: Colors.white);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xff00574b),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Reciclagem",
          body:
              "Clique no ícone RECICLAR.  Os recicláveis estão separados por corredores para uma experiência mais próxima do cotidiano, escolha seus recicláveis e envie para Meus Recicláveis.\n\nAhhh.. não se esqueça, seus resíduos devem ser entregues separados em sacolinhas individuais. 😉\n\nSua atitude transforma o mundo!♻️💚🌎",
          image: _buildImage('Reciclar'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Minhas Coletas",
          body:
              "Reciclando com o Trashapp você faz bem ao meio ambiente e ainda recebe benefícios incríveis e um deles são os TRASHCOINS, nossa moeda virtual.\n\nQuanto mais você recicla mais você ganha!😄",
          image: _buildImage('garbbag2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "TrashCoins",
          body:
              "Você pode trocar seus TRASHCOINS por cupons de desconto em produtos ou serviços da sua preferência.🤩\n\nNão deixe de dar um 👍 nos seus preferidos.",
          image: _buildImage('Tcoins'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "\n\nTermos de uso",
          bodyWidget: Column(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                width: double.infinity,
                height: SizeConfig.of(context).dynamicScaleHeight(size: 450),
                child: SingleChildScrollView(
                    child: Text(
                  data,
                  style: TextStyle(
                      fontSize: SizeConfig.of(context).dynamicScale(size: 22),
                      color: Colors.white),
                )),
              ),
              Container(
                child: Row(
                  children: [
                    Checkbox(
                        value: checkbox,
                        activeColor: TrashColors().buttonColor,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkbox = newValue;
                          });
                        }),
                    Text(
                      "Concorda com os termos de uso ?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              SizeConfig.of(context).dynamicScale(size: 16)),
                    )
                  ],
                ),
              )
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Pular',
        style: TextStyle(color: Colors.white),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Iniciar',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Color(0xff00884D),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
