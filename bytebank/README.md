# bytebank
Algumas lições aprendidas neste projeto:

Capturar erros ao executar o Future;
Identificar exceptions lançadas no Future;
Capturar exceptions específicas;
Capturar múltiplas exceptions;
Implementar exceptions personalizadas
Como por exemplo no arquivo [transaction_webClient.dart](https://github.com/WillianLauber/Flutter-fundamentos/blob/main/bytebank/lib/http/webClients/transaction_webClient.dart)

Evitar problema de código HTTP inesperado.

Um coneceito muito interessante que foi aplicado foi o da idempotência, ao se chamar uma função verifica-se se ela já não foi chamada antes, utilizado ao enviar transferências.
Para isso foi utilizado o UUID, universally unique identifier, um identificador único que pode ser gerado no dart por 4 tipos de algoritmos. Você pode verificá-las [aqui](https://en.wikipedia.org/wiki/Universally_unique_identifier#Versions)

**Padrões de projeto para testes**

Nos testes em Flutter devemos quando possível separar os unitários dos testes de widget por padrão há uma pasta com o nome "test" neste projeto foram utilizadas as seguintes pastas:
flows;
matchers;
mocks;
unit;
widgets.

**Os testes trabalham com uma expectativa:**

Para testes unitários utilizamos test  e a seguinte asserção para validar uma transferencia de 200 reais expect(transaction.value, 200);
Já para os de widget a função de testes é testWidgets para encontrar a feature transfer foram empregadas as seguintes funções para o Finder:

find.widgetWithIcon para buscar o ícone da funcionalidade;
find.widgetWithText para buscar o texto da funcionalidade.

**Buscando widgets com predicate**

é possível buscarr um widget pelo tipo e validar o seu conteúdo com o find.byWidgetPredicate, uma das vantagens disso é a reutilização do código:
```
 final transferFeatureItem = find.byWidgetPredicate((widget) {
   //   if(widget is FeatureItem){
  //      return (widget.nome == 'Transfer' &&  widget.icone == Icons.monetization_on);
  //    }

  //   return false;
  //  });
    final transferFeatureItem = find.byWidgetPredicate((widget) {
      return featureMatcher(widget, "Transfer", Icons.monetization_on);
    });

```

Foi adicionado um scroll no Widget que ocupava a tela inteira para não ocasionar overflow quando a tela é arrastada para baixo.

Durante a execução do teste, houve a dificuldade de identificar a apresentação do formulário de contatos mesmo após executarmos diversas chamadas
 do pump(). Isso aconteceu pois ele executa micro tarefas, o que não necessariamente resolve todos os problemas pendentes de nosso aplicativo durante o fluxo.

Para resolvê-los, foi utilizada a função pumpAndSettle(), que faz várias chamadas de pump() não haja mais pendências, sejam interações da tela, execuções de Future e assim por diante. 
 Foi adicionada a biblioteca mockito ao dev_dependencies do arquivo pubspec.yam para realizar a mockagem do objeto do banco de dados. 
 Objetos mock, ou objetos simulados, são objetos que simulam 
 o comportamento de objetos reais de forma controlada.
 No diretório "test", o arquivo mocks.dart é responsável pelos mocks. Nesse documento foi criada uma nova classe
  MockContactsDao, a partir da extensão extends da classe Mock foi implementada a classe ContactDao.
 ```
 class MockContactDao extends Mock implements ContactDao {
 0
 }
```
Para realizar o teste de fluxo foi injetada inicialmente como dependência a classe MockContactDao 
 ```
testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);
 ```
 Desta forma, há uma classe compatível ao ContactDao(), mas cujos comportamentos não serão usados.
 
Uma boa prática é agrupar os testes de acordo com as funcionalidades para isso foi utilizado o comando   ``` group('When Dashboard is opened', (){... ```
além disso é possível fazer um código sempre ser executado antes dos testes usando a função setUp:
 ```
  setUp(() async {
    mockContactDao = MockContactDao();
  });

 ```

Verificar chamadas de métodos de objetos simulados e quantidade de vezes que uma função é chamada:

 ```

    when(mockContactDao.findAll()).thenAnswer((invocation) async{
      debugPrint('name invocation ${invocation.memberName}');
        return [Contact(0, 'Alex', 10020)];
    }
    verify(mockContactDao.findAll()).called(1);

 ```
Gerar código automático do operador == e o hashcode;

Para não precisar fazer a injeção de dependências por toda a arvore de widgetes do app, foi refatorado para que ele consiga pegar o _webClient e o contactDao
 a partir do InheritedWidget.