# bytebank
Algumas lições aprendidas neste projeto:

**Padrões de projeto para testes**

Nos testes em Flutter devemos quando possível separar os unitários dos testes de widget por padrão há uma pasta com o nome "test"


**Os testes trabalham com uma expectativa:**

Para testes unitários utilizamos test  e a seguinte asserção para validar uma transferencia de 200 reais expect(transaction.value, 200);
Já para os de widget a função de testes é testWidgets para encontrar a feature transfer foram empregadas as seguintes funções para o Finder:

find.widgetWithIcon para buscar o ícone da funcionalidade;
find.widgetWithText para buscar o texto da funcionalidade.

**Buscando widgets com predicate**

é possível buscarr um widget pelo tipo e validar o seu conteúdo com o find.byWidgetPredicate, uma das vantagens disso é a reutilização do código:
```
 final transferFeatureItem = find.byWidgetPredicate((widget) {
      if(widget is FeatureItem){
        return (widget.nome == 'Transfer' &&  widget.icone == Icons.monetization_on);
      }

     return false;
    });

```

Adicionar scroll no Widget ocupando a tela inteira para não ocasionar overflow quando arrastar a tela para baixo.

